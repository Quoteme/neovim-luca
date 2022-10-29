-- vim: tabstop=2 shiftwidth=2 expandtab foldmethod=marker

-- {{{ Window and OS operations
WindowCMD = {}

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
  w = w or 100
  h = h or 20
  self.__index = self
  self.url = string.gsub(url, "~", os.getenv("HOME") .. "/")
  self.pid = nil
  self.x = x
  self.y = y
  self.width = w
  self.height = h
  self.scaler = "fit_contain"
  self.shown = false
  return o
end

function MyIMG.Image:command(seconds)
  return 'ueberzug layer --parser bash 0< <(' ..
            'declare -Ap add_command=( ' ..
              '[action]="add" ' ..
              '[identifier]="id0" ' ..
              '[x]="' .. self.x .. '" ' ..
              '[y]="' .. self.y .. '" ' ..
              '[width]="' .. self.width .. '" ' ..
              '[height]="' .. self.height .. '" ' ..
              '[scaler]="' .. self.scaler .. '" ' ..
              '[path]="' .. self.url .. '"); ' ..
              'sleep ' .. tostring(seconds) .. ')'
end

function MyIMG.Image:show(seconds)
  seconds = seconds or 1
  if not self.shown then
    self.shown = true
    self.pid = io.popen(self:command(seconds))
  end
end

function MyIMG.Image:hide()
  if self.shown then
    self.shown = false
    io.popen('kill ' .. self.pid)
    print("hiding image" .. self.url)
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

function MyIMG.Collection:show(seconds)
  for _, image in ipairs(self.images) do
    image:show(seconds)
  end
end
-- }}}

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

    -- for i,n in enumerate(iter) do
    --   print(i,n)
    -- end

    local placeholder = {}
    for i = 1,height,1 do
      table.insert(placeholder, {{"PLACEHOLDER", "error"}})
    end

    for i, node, metadata in iter do
      local row1, col1, row2, col2 =ts_utils.get_vim_range({ ts_utils.get_node_range(node) }, buffer) -- node:range()
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
        row1+offsetTop + MyIMG.numOfCurrentlyVisibleVirtualLines,
        vim.api.nvim_win_get_width(0),
        height)
      img:show(5)
      MyIMG.numOfCurrentlyVisibleVirtualLines = MyIMG.numOfCurrentlyVisibleVirtualLines + height
    end
  end)
end
-- }}}
