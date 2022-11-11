-- vim: tabstop=2 shiftwidth=2 expandtab foldmethod=marker

-- {{{ My Own functions 
-- {{{ Window and OS operations
WindowCMD = {}

function os.getfullpath(path)
  local fullpath = string.gsub(path, "~", os.getenv("HOME") .. "/")
  fullpath = string.gsub(fullpath, "file:", "")
  return fullpath
end

function os.capture(cmd)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    return s
end

function WindowCMD.getRowsAndCols()
  local rows = vim.api.nvim_win_get_height(0)
  local cols = vim.api.nvim_win_get_width(0)
  return rows, cols
end

function WindowCMD.getSize()
  local cmd = ('xdotool getwindowfocus getwindowgeometry | grep "Geometry" | sed "s/  Geometry: //"')
  local buf = os.capture(cmd)
  -- return buf:find("Connected to", 1, true) ~= nil
  local width = buf:match("%d+")
  local height = buf:match("x%d+"):gsub("x", "")
  return tonumber(width), tonumber(height)
end


--- Calculate the dimensions of a single character on screen
---@return number Dimensions of a cahracter
---@return number Dimensions of a cahracter
function WindowCMD.getCharSize()
  local width, height = WindowCMD.getSize()
  local rows, cols = WindowCMD.getRowsAndCols()
  return width / cols, height / rows
end
--}}}

-- {{{ Image loading
MyIMG = {}

-- {{{ Image
MyIMG.Image = {}
MyIMG.namespace = vim.api.nvim_create_namespace('myimgnamespace')

function MyIMG.Image:new(o, url, x, y, w, h)
  o = o or {}
  setmetatable(o, self)
  x = x or 0
  y = y or 0
  w = w or 20
  h = h or 20
  self.__index = self
  self.url = string.gsub(url, "~", os.getenv("HOME") .. "/")
  self.url = string.gsub(self.url, "file:", "")
  self.job = nil
  self.x = x
  self.y = y
  self.width = w
  self.height = h
  self.scaler = "fit_contain"
  self.shown = false
  return o
end

function MyIMG.Image:commandfifo()
    return string.format(
      vim.env.RUNTIME_EXTRA.."/scripts/ueberzug-fifo.sh %s %s %s %s %s %s",
      self.url,
      self.scaler,
      (self.x or 0),
      (self.y or 1),
      (self.width or 10),
      (self.height or 10))
end

function MyIMG.Image:show(seconds)
  seconds = seconds or 1
  if not self.shown then
    self.shown = true
    self.job = vim.fn.jobstart(self:commandfifo())
  end
end

function MyIMG.Image:hide()
  if self.shown then
    self.shown = false
    vim.fn.jobstop(self.job)
  end
end
-- }}}

-- {{{ Collection 
MyIMG.Collection = {}

function MyIMG.Collection:new(o, namespace)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.images = {}
  self.namespace = vim.api.nvim_create_namespace(namespace)
  return o
end

function MyIMG.Collection:add(image)
  table.insert(self.images, image)
end

-- TODO:add online image previews by using curl
function MyIMG.Collection:show(seconds)
  for _, image in ipairs(self.images) do
    image:show(seconds)
  end
end
-- }}}

--- Show the image which is pointed to by the cursor
---@param width number Width of the image
---@param height number Height of the image
function MyIMG.showUnderCursor(width, height)
  width = width or 20
  height = height or 20
  if vim.treesitter.get_node_at_cursor() == "link_destination" or vim.treesitter.get_node_at_cursor() == "attribute_value" then
    local tsu = require('nvim-treesitter.ts_utils')
    local url = tsu.get_node_text(tsu.get_node_at_cursor())[1]
    local buffer = vim.api.nvim_get_current_buf()
    local row1, col1, row2, col2 = tsu.get_vim_range({ tsu.get_node_range(tsu.get_node_at_cursor()) }, buffer) -- node:range()
    local img = MyIMG.Image:new(nil, url, col1+1, row1+1, width, height)
    img:show("infinity")
    vim.fn.getchar()
    img:hide()
  else
    print("No link found")
  end
end

function MyIMG.renameUnderCursorFromFilesystem()
  if vim.treesitter.get_node_at_cursor() == "link_destination" or vim.treesitter.get_node_at_cursor() == "attribute_value" then
    local tsu = require('nvim-treesitter.ts_utils')
    local node = tsu.get_node_at_cursor()
    local url = tsu.get_node_text(node)[1]
    url = os.getfullpath(url)
    require("notify")("Enter a new name for " .. url .. ". Leave empty to cancel.", "info", { title = "Rename file" })
    local newname = vim.fn.input("New name: ", url)
    if newname ~= "" then
      os.rename(url, newname)
      -- now change the text in the buffer
      local buffer = vim.api.nvim_get_current_buf()
      local row1, col1, row2, col2 =tsu.get_vim_range({ tsu.get_node_range(node) }, buffer) -- node:range()
      local line = vim.api.nvim_buf_get_lines(buffer, row1-1, row1, false)[1]
      print(vim.inspect( line:sub(0, col1+1) ))
      print(vim.inspect( line:sub(col2+1) ))
      local nline = line:sub(0, col1-1) .. newname .. line:sub(col2+1)
      vim.api.nvim_set_current_line(nline)
      require("notify")("File renamed", "info", { title = "File renamed" })
    else
      require("notify")("File not renamed because new name was empty", "warn", { title = "File not renamed" })
    end
  else
    print("No link found")
  end
end

function MyIMG.deleteUnderCursorFromFilesystem()
  if vim.treesitter.get_node_at_cursor() == "link_destination" or vim.treesitter.get_node_at_cursor() == "attribute_value" then
    local tsu = require('nvim-treesitter.ts_utils')
    local url = tsu.get_node_text(tsu.get_node_at_cursor())[1]
    url = os.getfullpath(url)
    require("notify")("Do you want to delete " .. url .. "? y/n", "info", { title = "Confirm image deletion" })
    local answer = vim.fn.getchar()
    if answer == 121 then
      os.remove(url)
      require("notify")("Image deleted", "info", { title = "Image deleted" })
    else
      require("notify")("Image not deleted", "warn", { title = "Image not deleted" })
    end
  else
    print("No link found")
  end
end

function MyIMG.showImg(url)
  local img = MyIMG.Image:new(nil, url)
  img:show()
end;

function MyIMG.showFull(url)
  local img = MyIMG.Image:new(nil, url)
  img.x = 0
  img.y = 0
  img.width = vim.api.nvim_win_get_width(0)
  img.height = vim.api.nvim_win_get_height(0)
  img:show(5)
end;

function MyIMG.clearVirtualText()
  vim.api.nvim_buf_clear_namespace(0, MyIMG.namespace, 0, -1)
end

function MyIMG.showAllImages(height, offsetTop, offsetLeft)
  height = height or 10
  offsetTop = offsetTop or 1
  offsetLeft = offsetLeft or 4
  MyIMG.clearVirtualText()
  MyIMG.numOfCurrentlyVisibleVirtualLines = 0;
  local query = vim.treesitter.query.parse_query('markdown_inline', '(image) @image')

  local buffer = vim.api.nvim_get_current_buf()
  local buf_highlighter = require('vim.treesitter.highlighter').active[buffer]

  local line_count = vim.api.nvim_buf_line_count(buffer)
  local ts_utils = require('nvim-treesitter.ts_utils')

  buf_highlighter.tree:for_each_tree(function(tstree, tree)
    if tree:lang() ~= 'markdown_inline' then
      return
    end

    local root = tstree:root()
    local iter = query:iter_captures(root, buffer, 0, line_count + 1)

    local placeholder = {}
    for i = 1,height,1 do
      table.insert(placeholder, {{"PLACEHOLDER", "error"}})
    end

    for i, node, metadata in iter do
      local row1, col1, row2, col2 =ts_utils.get_vim_range({ ts_utils.get_node_range(node) }, buffer) -- node:range()
      if vim.fn.foldclosed(row1)==-1 then
        -- print(i, row1, col1, row2, col2, vim.inspect(node), vim.inspect(metadata))
        -- `node` has two subnodes:
        -- ![here is some description]
        -- (here is the url)
        -- we now get the second node
        local locationNode = ts_utils.get_named_children(node)[2]
        -- now we get the text corresponding to the second node
        -- because the location consists of only one line, we get the first element
        local locationURL = ts_utils.get_node_text(locationNode, buffer)[1]
        locationURL = string.gsub(locationURL, "file:", "")
        locationURL = string.gsub(locationURL, "~", os.getenv("HOME") .. "/")
        -- local location = 
        local mark_id = vim.api.nvim_buf_set_extmark(
          vim.fn.bufnr('%'),
          MyIMG.namespace,
          row1, -- range[1],
          0, -- range[2],
          {
            virt_lines_above = true,
            virt_lines = placeholder
        })
        local img = MyIMG.Image:new(nil,
          locationURL,
          col1+offsetLeft,
          row1+offsetTop + MyIMG.numOfCurrentlyVisibleVirtualLines - vim.fn.winline(),
          nil,
          height)
        img:show(5)
        MyIMG.numOfCurrentlyVisibleVirtualLines = MyIMG.numOfCurrentlyVisibleVirtualLines + height
      else
        -- print("folded")
      end
    end
  end)
end
-- }}}

-- {{{ General functions
function colorpicker()
  local cmd = ('xcolor')
  local buf = os.capture(cmd)
  vim.cmd("normal! i" .. buf)
end
-- }}}
-- }}}

-- {{{ Plugins loading
-- {{{ Legendary.nvim
--
-- A legend for your keymaps, commands, and autocmds,
-- with which-key.nvim integration
--

-- First set up `dressing.nvim` for better visuals
require('dressing').setup()

-- Then set up `legendary.nvim`
require('legendary').setup({
  keymaps = {
    -- open command palette like VSCode
    { '<C-S-P>', ':Legendary<CR>', description="open command palette (legendary.nvim)" },
    -- folds
    { '<C-+>', ':lua require("fold-cycle").open()<CR>', description="open folds" },
    { '<C-->', ':lua require("fold-cycle").close()<CR>', description="close folds" },
    { '<C-A-+>', ':lua require("fold-cycle").open_all()<CR>', description="open all folds" },
    { '<C-A-->', ':lua require("fold-cycle").close_all()<CR>', description="close all folds" },
    -- Code action
    { '<A-a>'     , ':CodeActionMenu<CR>'           , description="code action menu" } ,
    { '<A-b>'     , ':lua vim.lsp.buf.definition()<CR>' , description="go to definition" } ,
    -- Buffer stuff
    { '<C-Tab>'   , ':BufferNext<CR><ESC>'         , description='next buffer'},
    { '<C-S-Tab>' , ':BufferPrevious<CR><ESC>'     , description='previous buffer'},
    { '<M-Tab>'   , ':BufferMoveNext<CR><ESC>'     , description='swap buffer with next'},
    { '<M-S-Tab>' , ':BufferMovePrevious<CR><ESC>' , description='swap buffer with previous'},
    { '<C-W>'     , ':BufferClose<CR><ESC>'        , description='close buffer'},
    { '<C-S-W>'   , ':BufferClose!<CR>'            , description='force close buffer'},
    -- Hotkeys
    { '<F1>' , ':Neotree filesystem toggle left<CR>' , description='open neotree'} ,
    { '<F1>' , ':SymbolsOutline<CR>' , description='symbols outline'} ,
    { '<F1>' , ':TodoTelescope<CR>' , description='list all todos'} ,
  }          ,
  which_key = {
    auto_register = true,
  },
})

-- }}}
-- }}}
