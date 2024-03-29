-- vim: tabstop=2 shiftwidth=2 expandtab foldmethod=marker

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
    -- {{{ command palette like VSCode
    { '<C-S-P>', ':Legendary<CR>',                                       description =
    "open command palette (legendary.nvim)" },
    { '<C-S-F>', ':Telescope live_grep<cr>',                             description = "find command" },
    { '<C-S-X>', ':Telescope commands<cr>',                              description = "find command" },
    { '<A-K>',   ':Telescope keymaps<cr>',                               description = "find keymaps" },
    -- }}}
    -- {{{ folds
    { '<C-+>',   ':lua require("fold-cycle").open()<CR>',                description = "open folds" },
    { '<C-->',   ':lua require("fold-cycle").close()<CR>',               description = "close folds" },
    { '<C-A-+>', ':lua require("fold-cycle").open_all()<CR>',            description = "open all folds" },
    { '<C-A-->', ':lua require("fold-cycle").close_all()<CR>',           description = "close all folds" },
    -- }}}
    -- {{{ Code action
    { '<A-a>',   ':Lspsaga code_action<CR>',                             description = "code action menu" },
    { '<A-b>',   ':lua vim.lsp.buf.definition()<CR>',                    description = "go to definition" },
    -- show the hover information when pressing A-h
    { '<A-h>',   ':lua vim.lsp.buf.hover()<CR>',                         description = "show hover information" },
    { '<A-H>',   ':Telescope hoogle<CR>',                                description = "hoogle" },
    { '<A-i>',   ':Telescope lsp_incoming_calls<cr>',                    description = "incoming references" },
    { '<A-o>',   ':Telescope lsp_outgoing_calls<cr>',                    description = "outgoing references" },
    -- show the diagnostics when pressing A-l
    { '<A-l>',   ':Lspsaga show_line_diagnostics<CR>',                   description = "show line diagnostics" },
    { '<A-c>',   ':Lspsaga show_cursor_diagnostics<CR>',                 description = "show cursor diagnostics" },
    -- show the definition preview when pressing A-d
    { '<A-d>',   ':lua vim.lsp.buf.definition()<CR>',                    description = "show definition preview" },
    { '<A-r>',   ':Lspsaga rename ++project<cr>',                        description = "rename symbol" },
    { '<A-j>',   ':lua vim.diagnostic.goto_next()<CR>',                  description = "next diagnostic" },
    { '<A-k>',   ':lua vim.diagnostic.goto_prev()<CR>',                  description = "previous diagnostic" },
    { '<A-n>',   ':lua vim.diagnostic.goto_next()<CR>',                  description = "next diagnostic" },
    { '<A-p>',   ':lua vim.diagnostic.goto_prev()<CR>',                  description = "previous diagnostic" },
    { '<A-x>',   ':Telescope lsp_document_diagnostics<cr>',              description = "document diagnostics" },
    { '<A-q>',   ':quit<cr>',                                            description = "quit" },
    { '<A-t>',   ':TodoTelescope<CR>',                                   description = "show todos" },
    { '<A-w>',   ':lua require("copilot.suggestion").accept_word()<CR>', description = "copilot: accept word" },
    { '<A-e>',   ':lua require("copilot.suggestion").accept_line()<CR>', description = "copilot: accept line" },
    -- }}}
    -- {{{ LSP
    {
      '<F21>', -- S->F9
      function()
        if vim.bo.filetype == 'dart' then
          vim.cmd('FlutterRun')
        elseif vim.bo.filetype == 'nix' then
          vim.cmd('!nix run')
        end
      end,
      description = "debug program"
    },
    {
      '<F22>', -- S-F10
      function()
        require('dap').continue()
      end,
      description = "run program"
    },
    -- }}}
    -- {{{ Buffer stuff
    { '<C-Tab>',   ':BufferNext<CR><ESC>',                       description = 'next buffer' },
    { '<C-S-Tab>', ':BufferPrevious<CR><ESC>',                   description = 'previous buffer' },
    { '<M-Tab>',   ':BufferMoveNext<CR><ESC>',                   description = 'swap buffer with next' },
    { '<M-S-Tab>', ':BufferMovePrevious<CR><ESC>',               description = 'swap buffer with previous' },
    { '<C-W>',     ':BufferClose<CR><ESC>',                      description = 'close buffer' },
    { '<C-S-W>',   ':BufferClose!<CR>',                          description = 'force close buffer' },
    { '<C-M-K>',   ':windo wincmd K<CR>',                        description = 'switch to horizontal buffer' },
    { '<C-M-H>',   ':windo wincmd H<CR>',                        description = 'switch to vertical buffer' },
    -- }}}
    -- {{{ Hotkeys
    { '<F1>',      ':Neotree filesystem toggle left reveal<CR>', description = 'open neotree' },
    { '<F2>',      ':SymbolsOutline<CR>',                        description = 'symbols outline' },
    { '<F3>',      ':TodoTelescope<CR>',                         description = 'list all todos' },
    {
      '<F5>',
      function()
        if vim.bo.filetype == 'dart' then
          vim.cmd('FlutterRun')
        elseif vim.bo.filetype == 'nix' then
          vim.cmd('!nix run')
        elseif vim.bo.filetype == 'tex' then
          vim.cmd('!latexmk -pdf')
        elseif vim.bo.filetype == 'markdown' then
          vim.cmd('Pandoc')
        elseif vim.bo.filetype == 'python' then
          vim.cmd('!python3 %')
        elseif vim.bo.filetype == 'sh' then
          vim.cmd('!sh %')
        elseif vim.bo.filetype == 'lua' then
          vim.cmd('!lua %')
        elseif vim.bo.filetype == 'c' then
          vim.cmd('!gcc % -o %<')
          vim.cmd('!./%<')
        elseif vim.bo.filetype == 'cpp' then
          vim.cmd('!g++ % -o %<')
          vim.cmd('!./%<')
        elseif vim.bo.filetype == 'java' then
          vim.cmd('!javac %')
          vim.cmd('!java %<')
        elseif vim.bo.filetype == 'rust' then
          vim.cmd('!rustc %')
          vim.cmd('!./%<')
        elseif vim.bo.filetype == 'go' then
          vim.cmd('!go run %')
        end
      end,
      description = 'compile project'
    },
    -- }}}
  },
  which_key = {
    auto_register = true,
  },
})
-- }}}

-- {{{ barbecue.vim
-- require("barbecue").setup()
-- }}}

-- {{{ lualine
local myBranch = {
  'branch',
  on_click = function()
    vim.cmd('Telescope git_branches')
  end,
}
local myDiagnostic = {
  'diagnostics',
  on_click = function()
    vim.cmd [[TroubleToggle]]
  end,
}
local myFiletype = { 'filetype', icon_only = true }
local navic = require("nvim-navic")
local myNvimNavic = {
  navic.get_location, cond = navic.is_available
}
require('lualine').setup {
  options = {
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = { '', '' },
    section_separators = { '', '' },
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { myBranch, 'diff', myDiagnostic },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { myNvimNavic, 'encoding', myFiletype }, -- require('copilot_status').status_string
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
-- }}}

-- {{{ Autosessions
MySession = {}
function MySession:saveDialog()
  vim.ui.input(
    { prompt = "Session name: " },
    function(sessionName)
      sessionName = vim.fn.getcwd() .. "/" .. sessionName
      sessionName = string.gsub(sessionName, "/", "%")
      local saveLocation = vim.fn.stdpath("data") .. "/sessions/"
      vim.cmd("SaveSession " .. saveLocation .. sessionName)
    end
  )
end

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
require('auto-session').setup {
  log_level = "error",
  auto_session_root_dir = vim.fn.getcwd() .. '/.sessions/',
  pre_save_cmds = {
    function()
      if (not vim.fn.isdirectory(vim.fn.getcwd() .. '/.sessions/')) then
        vim.fn.mkdir(vim.fn.getcwd() .. '/.sessions/')
      end
      vim.o.sessionoptions = ""
      vim.opt.winminheight = 1
      vim.opt.winheight = 1000000000
      vim.opt.winminwidth = 1
      vim.opt.winwidth = 1000000000
      return vim.cmd("Neotree filesystem close")
    end
  },
  post_save_cmds = {
    function()
      return vim.cmd("Neotree filesystem toggle left")
    end
  },
}
-- }}}

-- {{{
require('litee.lib').setup({
  tree = {
    icon_set = "codicons"
  },
  panel = {
    orientation = "left",
    panel_size  = 30
  }
})
require('litee.calltree').setup({})
require('litee.symboltree').setup({})
require 'litee.filetree'.setup {}
-- }}}

-- {{{ flutter-tools.nvim
require("flutter-tools").setup {
  debugger = {
    enabled = true,
    register_configurations = function(_)
      require('dap.ext.vscode').load_launchjs()
    end,
  },
  flutter_path = vim.fn.getenv("FLUTTER_SDK") .. "/bin/flutter",
  widget_guides = {
    enabled = true,
  },
  lsp = {
    color = {
                              -- show the derived colours for dart variables
      enabled = true,         -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = true,      -- highlight the background
      foreground = false,     -- highlight the foreground
      virtual_text = true,    -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
  }
}
require("telescope").load_extension("flutter")
-- }}}

-- {{{ Debug-Adapter-Protocol
local dap = require('dap')
-- {{{ Python
dap.adapters.python = {
  type = 'executable',
  command = vim.fn.exepath('python'),
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = "Launch file",
    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return vim.fn.exepath('python')
      end
    end,
  },
}
-- }}}
-- {{{ Dart / Flutter
dap.adapters.dart = {
  type = 'executable',
  command = vim.fn.exepath('dart'),
  args = { vim.fn.getenv('FLUTTER_SDK') .. '/packages/flutter_tools/lib/src/commands/debug_adapter.dart', 'dap' },
}
dap.configurations.dart = {
  {
    type = 'dart',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
  },
  {
    type = "dart",
    request = "launch",
    name = "Launch Flutter",
    program = "${workspaceFolder}/lib/main.dart",
    args = { "--flavor", "dev" },
  },
}
-- }}}
-- cpp debugging
dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode',  -- my binary was called 'lldb-vscode-11'
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "lldb",
    type = "cpp",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    externalTerminal = false,
    stopOnEntry = false,
    args = {}
  },
}
require('dap.ext.vscode').load_launchjs()
require('dapui').setup()
-- }}}

-- {{{ Testing
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-deno"),
    require("neotest-plenary"),
    require("neotest-haskell"),
    require('neotest-dart') {
      command = 'flutter',
      use_lsp = true
    },
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})
require("coverage").setup()
-- }}}
