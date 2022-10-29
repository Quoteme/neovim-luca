-- vim: tabstop=2 shiftwidth=2 expandtab foldmethod=marker

-- {{{ Image loading
MyIMG = {}

-- {{{ Image
MyIMG.Image = {}
MyIMG.namespace = vim.api.nvim_create_namespace('myimgnamespace')

function MyIMG.Image:new(o, url)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.url = string.gsub(url, "~", os.getenv("HOME") .. "/")
  self.pid = nil
  self.x = 0
  self.y = 0
  self.width = 50
  self.height = 10
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
    self.pid = os.execute(self:command(seconds))
    print("showing image" .. self.url)
  end
end

function MyIMG.Image:hide()
  if self.shown then
    self.shown = false
    os.execute('kill ' .. self.pid)
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

function MyIMG.showAllImages()
  local query = vim.treesitter.query.parse_query('markdown_inline', '(image) @image')

  local buffer = vim.api.nvim_get_current_buf()
  local buf_highlighter = require('vim.treesitter.highlighter').active[buffer]

  local line_count = vim.api.nvim_buf_line_count(buffer)
  local ts_utils = require('nvim-treesitter.ts_utils')

  local c = MyIMG.Collection:new(nil, "imagepreview")

  buf_highlighter.tree:for_each_tree(function(tstree, tree)
    if tree:lang() ~= 'markdown_inline' then
      return
    end

    local root = tstree:root()
    local iter = query:iter_captures(root, buffer, 0, line_count + 1)

    for _, node, _ in iter do
      -- print(({ ts_utils.get_vim_range({ ts_utils.get_node_range(node) }, buffer) })[1])
      local range = { ts_utils.get_vim_range({ ts_utils.get_node_range(node) }, buffer) }
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
        range[1], -- range[1],
        0, -- range[2],
        {
          virt_lines_above = true,
          virt_lines = {
            {{"PLACEHOLDER", "error"}},
            {{"PLACEHOLDER", "error"}},
            {{"PLACEHOLDER", "error"}},
            {{"PLACEHOLDER", "error"}},
            {{"PLACEHOLDER", "error"}},
            {{"PLACEHOLDER", "error"}},
            {{"PLACEHOLDER"..locationURL, "error"}},
        }
      })
    end
  end)
end
-- }}}
