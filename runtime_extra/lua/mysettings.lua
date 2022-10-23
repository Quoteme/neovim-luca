-- vim: tabstop=2 shiftwidth=2 expandtab foldmethod=marker

-- {{{ Image loading
MyIMG = {}

MyIMG.Image = {}

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

function MyIMG.Image:show(seconds)
  seconds = seconds or 1
  if not self.shown then
    self.shown = true
    self.pid = os.execute(
      'ueberzug layer --parser bash 0< <(' ..
        'declare -Ap add_command=( ' ..
          '[action]="add" ' ..
          '[identifier]="id0" ' ..
          '[x]="' .. self.x .. '" ' ..
          '[y]="' .. self.y .. '" ' ..
          '[width]="' .. self.width .. '" ' ..
          '[height]="' .. self.height .. '" ' ..
          '[scaler]="' .. self.scaler .. '" ' ..
          '[path]="' .. self.url .. '"); ' ..
          'sleep 1)'
    )
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
-- }}}
