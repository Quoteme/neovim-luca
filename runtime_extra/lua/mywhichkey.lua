-- vim: tabstop=2 shiftwidth=2 expandtab
local wk = require("which-key")
wk.setup{}
wk.register({
  a = {":CodeActionMenu<CR>", "code action"},
  B = {
    name = "buffer settings",
    l = {":Buffers<CR>", "list Buffers"},
    p = {"<cmd>BufferPrevious<CR>", "previous buffer"},
    n = {"<cmd>BufferNext<CR>", "next buffer"},
    P = {"<cmd>BufferMovePrevious<CR>", "swap with preceding buffer"},
    N = {"<cmd>BufferMoveNext<CR>", "swap with next buffer"},
    c = {"<cmd>BufferClose<CR>", "close buffer"},
    },
  --t = {":tab ball<CR>", "make all Buffers tabs"},
  z = {":Twilight<CR>", "toggle twilight"},
  n = {
    name = "Nabla latex view",
    a = {"<cmd>lua require('nabla').action()<CR>", "action"},
    p = {"<cmd>lua require('nabla').popup()<CR>", "popup"},
    },
  m = {
    name = "codewindow.nvim - code minimap",
    o = {":lua require('codewindow').open_minimap()<CR>", "open minimap"},
    c = {":lua require('codewindow').close_minimap()<CR>", "close minimap"},
    f = {":lua require('codewindow').toggle_minimap()<CR>", "toggle minimap"},
    m = {":lua require('codewindow').toggle_focus()<CR>", "toggle focus"},
    },
  -- ? = {"<cmd>Cheatsheet<CR>", "Cheatsheet"},
  d = {
    name = "neogen documentation",
    d = {":Neogen<CR>", "document automatically"},
    f = {":Neogen func<CR>", "document function"},
    F = {":Neogen file<CR>", "document file"},
    c = {":Neogen class<CR>", "document class"},
    t = {":Neogen type<CR>", "document type"},
  },
  c = {
    ':exec &conceallevel ? "set conceallevel=0<CR>" : "set conceallevel=1"',
    "toggle conceal"
    },
  s = {
    name = "session",
    s = {":SaveSession<CR>", "save session"},
    c = {":lua MySession.saveDialog()<CR>", "create session"},
    r = {":RestoreSession<CR>", "restore session"},
    D = {":DeleteSession<CR>", "delete current session"},
    l = {":Autosession search<CR>", "list sessions to load"},
    d = {":Autosession delete<CR>", "list session for deletion"},
    },
  i = {
    name = "image tools",
    p = {":PasteImg<CR>", "paste from clipboard"},
    v = {":lua MyIMG.showUnderCursor(70,70)<CR>", "preview image under cursor"},
    s = {":!maim -su | xclip -selection clipboard -t image/png<CR>", "capture part of screen to clipboard"},
    d = {":lua MyIMG.deleteUnderCursorFromFilesystem()<CR>", "delete image under cursor"},
    r = {":lua MyIMG.renameUnderCursorFromFilesystem()<CR>", "rename image under cursor"},
    c = {":lua colorpicker()<CR>", "color picker"},
  },
  l = {
    name = "LSP commands",
    ["<"] = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "previous diagnostic"},
    [">"] = {"<cmd>lua vim.diagnostic.goto_next()<CR>", "next diagnostic"},
    D = {"<cmd>lua vim.lsp.buf.declaration()<CR>","goto declaration"},
    d = {"<cmd>lua vim.lsp.buf.definition()<CR>","goto definition"},
    h = {"<cmd>lua vim.lsp.buf.hover()<CR>","hover"},
    i = {"<cmd>lua vim.lsp.buf.implementation()<CR>","goto implementation"},
    s = {"<cmd>lua vim.lsp.buf.signature_help()<CR>","signature help"},
    w = {
      name = "Workspace commands",
        r = {"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>","remove workspace folder"},
        a = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>","add workspace folder"},
        l = {"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>","list workspace folders"},
      },
    t = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "type definition"},
    r = {"<cmd>lua vim.lsp.buf.rename()<CR>", "rename"},
    a = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "code action"},
    A = {":CodeActionMenu<CR>", "code action menu"},
    R = {"<cmd>lua vim.lsp.buf.references()<CR>", "goto references"},
    l = {"<cmd>lua vim.diagnostic.open_float()<CR>", "show diagnostics"},
    p = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "goto previous"},
    n = {"<cmd>lua vim.diagnostic.goto_next()<CR>", "goto next"},
    S = {"<cmd>lua vim.diagnostic.set_loclist()<CR>", "set loclist"},
    f = {"<cmd>lua vim.lsp.buf.format { async = true }<CR>", "format"},
    o = {
      name = "Overview diagnostics",
      o = {"<cmd>TroubleToggle<CR>", "toggle overview"},
      w = {"<cmd>TroubleToggle<CR>", "toggle workspace overview"},
      d = {"<cmd>TroubleToggle<CR>", "toggle document overview"},
      q = {"<cmd>TroubleToggle<CR>", "toggle quickfix overview"},
      l = {"<cmd>TroubleToggle<CR>", "toggle loclist overview"},
      r = {"<cmd>TroubleToggle<CR>", "toggle LSP references"},
      g = {"<cmd>lua trouble.open_with_trouble<CR>", "go to result"},
    }
    },
  e = {
    name = "evaluate using sniprun",
    e = {"<cmd>lua require'sniprun'.run()<cr>", "run line"},
    i = {"<cmd>lua require'sniprun'.info()<cr>", "sniprun info"},
    r = {"<cmd>lua require'sniprun'.reset()<cr>", "reset sniprun"},
    c = {"<cmd>lua require'sniprun'.clear_repl()<cr>", "clear sniprun repl memory"},
    x = {"<cmd>lua require'sniprun.display'.close()<cr>", "close sniprun"},
    l = {"<cmd>lua require'sniprun.live_mode'.toggle()<cr>", "sniprun live mode toggle"},
    },
  g = {
    name = "gitsigns",
    f = {
      name = "git picker",
      f = {":Telescope git_files<CR>", "git files"},
      s = {":Telescope git_status<CR>", "git status"},
      S = {":Telescope git_stash<CR>", "git stash"},
      b = {":Telescope git_branches<CR>", "git branches"},
      c = {":Telescope git_bcommits<CR>", "git commits (buffer)"},
      C = {":Telescope git_commits<CR>", "git commits (all)"},
    },
    h = {
      name = "hunk",
      s = {":Gitsigns stage_hunk<CR>", "git stage hunk"},
      r = {":Gitsigns reset_hunk<CR>", "git reset hunk"},
      u = {"<cmd>lua package.loaded.gitsigns.undo_stage_hunk()<CR>", "git undo stage hunk"},
      p = {"<cmd>lua package.loaded.gitsigns.preview_hunk()<CR>", "git preview hunk"},
    },
    ["<"] = {"<cmd>Gitsigns prev_hunk<CR>", "git previous hunk"},
    [">"] = {"<cmd>Gitsigns next_hunk<CR>", "git next hunk"},
    s = {"<cmd>lua package.loaded.gitsigns.stage_buffer()<CR>", "git stage buffer"},
    r = {"<cmd>lua package.loaded.gitsigns.reset_buffer()<CR>", "git reset buffer"},
    t = {"<cmd>lua package.loaded.gitsigns.toggle_current_line_blame()<CR>", "git toggle current line blame"},
    b = {"<cmd>lua package.loaded.gitsigns.blame_line()<CR>", "git blame line"},
    B = {"<cmd>lua package.loaded.gitsigns.blame_line{full=true}<CR>", "git blame line full"},
    d = {"<cmd>lua package.loaded.gitsigns.diffthis()<CR>", "git diff this"},
    D = {"<cmd>lua package.loaded.gitsigns.diffthis('~')<CR>", "git diff this ~"},
    x = {"<cmd>lua package.loaded.gitsigns.toggle_delete()<CR>", "git toggle delete"},
  },
  -- a = {
  --   name = "aerial.nvim",
  --   t = {"<cmd>AerialToggle!<CR>", "toggle aerial"},
  --   T = {"<cmd>AerialTreeToggle!<CR>", "toggle aerial tree"},
  --   p = {"<cmd>AerialPrev<CR>", "aerial previous"},
  --   n = {"<cmd>AerialNext<CR>", "aerial next"},
  --   P = {"<cmd>AerialPrevUp<CR>", "aerial previous up"},
  --   N = {"<cmd>AerialNextUp<CR>", "aerial next up"},
  -- },
  T = {
    name = "neotree",
    f = {":Neotree filesystem toggle left reveal<CR>", "show filesystem"},
    b = {":Neotree buffers toggle float<CR>", "show buffers"},
    g = {":Neotree git_status toggle right<CR>", "show git status"},
  },
  F = {
    name = "fold-cycle",
    -- cycle folds
    c = {"<cmd>lua require('fold-cycle').close()<CR>", "fold: close  level"},
    o = {"<cmd>lua require('fold-cycle').open()<CR>", "fold: open  level"},
    t = {"<cmd>lua require('fold-cycle').toggle_all()<CR>", "fold: toggle "},
  },
  f = {
    name = "Telescope find",
    f = {":Telescope find_files<cr>"                    , "find files"},
    g = {":Telescope live_grep<cr>"                     , "find with live grep"},
    o = {":Telescope oldfiles<cr>"                      , "find previously open files"},
    c = {":Telescope commands<cr>"                      , "find commands (neovim/plugin)"},
    C = {":Telescope command_history<cr>"               , "find command history"},
    h = {":Telescope search_history<cr>"                , "find in search history"},
    H = {":Telescope help_tags<cr>"                     , "find help tags (neovim/plugin)"},
    m = {":Telescope marks<cr>"                         , "find marks"},
    M = {":Telescope man_pages<cr>"                     , "find manpage entries"},
    B = {":Telescope buffers<cr>"                       , "find in buffers"},
    r = {":Telescope lsp_references<cr>"                , "find references"},
    ["<"] = {":Telescope lsp_incoming_calls<cr>"        , "find incoming calls"},
    [">"] = {":Telescope lsp_outgoing_calls<cr>"        , "find outgoing calls"},
    s = {":Telescope lsp_document_symbols<cr>"          , "find document symbols"},
    w = {":Telescope lsp_workspace_symbols<cr>"         , "find workspace symbols"},
    W = {":Telescope lsp_dynamic_workspace_symbols<cr>" , "find dynamic workspace symbols"},
    D = {":Telescope diagnostics<cr>"                   , "find diagnostics"},
    i = {":Telescope lsp_implementations<cr>"           , "find implementations"},
    d = {":Telescope lsp_definitions<cr>"               , "find definitions"},
    t = {":Telescope lsp_type_definitions<cr>"          , "find type definitions"},
    b = {":Telescope current_buffer_fuzzy_find<cr>"     , "find current buffer fuzzy find"},
    j = {":Telescope jumplist<cr>"                      , "find jumplist"},
    S = {":Telescope spell_suggest<cr>"                 , "find spell suggestions"},
    v = {":Telescope vim_options<cr>"                   , "find vim options"},
    a = {":Telescope autocommands<cr>"                  , "find autocommands"},
    R = {":Telescope registers<cr>"                     , "find registers"},
    k = {":Telescope keymaps<cr>"                       , "find keymaps"},
    F = {":Telescope filetypes<cr>"                     , "find filetypes"},
    y = {":Telescope colorscheme<cr>"                   , "find colorschemes"},
    x = {":Telescope resume<cr>"                        , "resume previous search"},
  },
  t = {
    name = "vim-test",
    n = {":TestNearest<CR>", "test nearest"},
    f = {":TestFile<CR>", "test file"},
    s = {":TestSuite<CR>", "test suite"},
    l = {":TestLast<CR>", "test last"},
    v = {":TestVisit<CR>", "visit test file"},
  };
}, {
  mode = "n",
  prefix = "<leader>"
})


wk.register({
  a = {":CodeActionMenu<CR>", "code action"},
  e = {
    name = "evaluate using sniprun",
    e = {"<cmd>lua require'sniprun'.run('v')<cr>", "run visual selection"},
  },
  g = {"<C-U>Gitsigns select_hunk<CR>", "gitsigns selected hunk"},
  i = {"<Plug>VimspectorBalloonEval<CR>", "vimspector inspect"}
}, {
  mode = "v",
  prefix = "<leader>"
})

  wk.register({
    E = {"evaluate visual selection"},
    e = {
      name = "evaluate",
      b = {"buffer"},
      e = {"inner form"},
      ["!"] = {"replace by result"}
      },
    l = {
      name = "log buffer",
      s = {"split horizontally"},
      v = {"split vertically"},
      t = {"new tab"},
      r = {"clear - soft reset"},
      R = {"clear - hard reset"},
      },
    j = {
      name = "jdtls",
      o = {"<cmd>lua require'jdtls'.organize_imports()<CR>","organize imports"},
      v = {"<cmd>lua require'jdtls'.extract_variable()<CR>","extract variable"},
      V = {"<cmd>lua require'jdtls'.extract_variable(true)<CR>","extract variable"},
      c = {"<cmd>lua require'jdtls'.extract_constant(true)<CR>","extract constant"},
      C = {"<cmd>lua require'jdtls'.extract_constant(true)<CR>","extract constant"},
      m = {"<cmd>lua require'jdtls'.extract_method(true)<CR>","extract method"},
      d = {
        name = "jdtls debug",
        c = {"<cmd>lua require'jdtls'.test_class()<CR>","test class"},
        m = {"<cmd>lua require'jdtls'.test_nearest_method()<CR>","test nearest method"},
        },
      },
    d = {
      name = "debug (dap)",
      t = {":lua require('dapui').toggle()<CR>", "toggle dapui"},
    },
    D = {
      name = "debug (vimspector)",
      c = {"<Plug>VimspectorContinue", "continue"},
      p = {"<Plug>VimspectorPause", "pause"},
      b = {"<Plug>VimspectorToggleBreakpoint", "breakpoint toggle"},
      B = {
        name = "breakpoint options",
        l = {"<Plug>VimspectorBreakpoints", "breakpoint list"},
        c = {"<Plug>VimspectorToggleConditionalBreakpoint", "conditional breakpoint toggle"},
        C = {":call vimspector#ClearBreakpoints()", "clear all breakpoints"},
        f = {"<Plug>VimspectorAddFunctionBreakpoint", "function breakpoint toggle"},
      },
      C = {"<Plug>VimspectorRunToCursor", "run to cursor"},
      l = {":call vimspector#Launch()<CR>", "LAUNCH"},
      L = {"<Plug>VimspectorGoToCurrentLine", "move to current line"},
      S = {
        name = "session",
        s = {"<Plug>VimspectorStop", "stop"},
        r = {"<Plug>VimsspectorRestart", "restart"},
        S = {":VimspectorMkSession<CR>", "save session"},
        L = {":VimspectorLoadSession<CR>", "load session"},
      },
      s = {
        name = "step",
        i = {"<Plug>VimspectorStepInto", "step into"},
        o = {"<Plug>VimspectorStepOver", "step over"},
        O = {"<Plug>VimspectorStepOut", "step out"},
      },
      i = {"<Plug>VimspectorBalloonEval", "debug inspect"},
      f = {
        name = "frame",
        u = {"<Plug>VimspectorUpFrame", "up frame"},
        d = {"<Plug>VimspectorDownFrame", "down frame"},
      }
    },
    c = {
      name = "compile using pandoc",
      p = {":!pandoc<space>%<space>-o<space>%:r.pdf<CR>", "to pdf"},
      h = {":!pandoc<space>%<space>-o<space>%:r.html<CR>", "to html"},
      },
    f = {
      name = "flutter-tools",
      r = {":FlutterRun<cr>", "Run the current flutter project"},
      d = {":FlutterDevices<cr>", "Brings up a list of connected flutter devices to select from."},
      e = {":FlutterEmulators<cr>", "Brings up a list of available flutter emulators to select from."},
      R = {":FlutterReload<cr>", "Reloads the running flutter project."},
      s = {":FlutterRestart<cr>", "Restarts the running flutter project."},
      q = {":FlutterQuit<cr>", "Quits the running flutter project."},
      D = {":FlutterDetach<cr>", "Detaches the running flutter project."},
      o = {":FlutterOutlineToggle<cr>", "Toggles the outline of the current flutter project."},
      S = {":FlutterDevTools<CR>", "Starts a new flutter devtools server."},
      c = {":FlutterCopyProfilerUrl<CR>", "Copies the url of the current flutter devtools server."},
      l = {":FlutterLspRestart<CR>", "Restarts the flutter LSP server."},
      u = {":FlutterSuper<CR>", "Go to superclass"},
      a = {":FlutterReanalyze<cr>", "Reanalyzes the current flutter project."},
      },
  }, { prefix = "<localleader>" })
-- end

-- Default localleader settings
wk.register({
  r = {
    name = "REPL (vim-slime)",
    r = {"<Plug>SlimeRegionSend", "send region"},
    p = {"<Plug>SlimeParagraphSend", "send paragraph"},
    c = {"<Plug>SlimeConfig", "edit slime config"},
    }
}, { prefix = "<localleader>" })

-- Default keybingigs in normal mode without any modifiers
wk.register({
  c = {
    s = "change surrounding char arg1 with arg2. cs\"\'"
    },
  g = {
    b = {"<cmd>BufferPrevious<CR>", "previous buffer"},
    B = {"<cmd>BufferNext<CR>", "next buffer"},
    },
})
