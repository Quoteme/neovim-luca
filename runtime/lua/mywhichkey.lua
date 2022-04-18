local wk = require("which-key")
wk.setup{}
wk.register({
  b = {
    name = "buffer settings",
    l = {":Buffers<CR>", "list Buffers"},
    p = {"<cmd>BufferPrevious<CR>", "previous buffer"},
    n = {"<cmd>BufferNext<CR>", "next buffer"},
    P = {"<cmd>BufferMovePrevious<CR>", "swap with preceding buffer"},
    N = {"<cmd>BufferMoveNext<CR>", "swap with next buffer"},
    c = {"<cmd>BufferClose<CR>", "close buffer"},
    },
  --t = {":tab ball<CR>", "make all Buffers tabs"},
  t = {":twilight<CR>", "toggle twilight"},
  n = {
    name = "Nabla latex view",
    a = {"<cmd>lua require('nabla').action()<CR>", "action"},
    p = {"<cmd>lua require('nabla').popup()<CR>", "popup"},
    },
  -- ? = {"<cmd>Cheatsheet<CR>", "Cheatsheet"},
  c = {
    ':exec &conceallevel ? "set conceallevel=0<CR>" : "set conceallevel=1"',
    "toggle conceal"
    },
  i = {
    name = "image",
    i = {":read !echo $(maim -suo | base64)<CR>", "insert image inline (base64)"},
    s = {":!maim -suo screenshot$(($(ls | grep 'screenshot' | wc -l) +1)).png<CR>:read !echo \\[screenshot$(ls | grep 'screenshot' | wc -l).png\\]\\(screenshot$(ls | grep 'screenshot' | wc -l).png\\)", "save image"},
    },
  l = {
    name = "LSP commands",
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
    R = {"<cmd>lua vim.lsp.buf.references()<CR>", "goto references"},
    l = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "show line diagnostics"},
    p = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "goto previous"},
    n = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "goto next"},
    S = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "set loclist"},
    f = {"<cmd>lua vim.lsp.buf.formatting()<CR>", "format"},
    },
  e = {
    name = "evaluate using sniprun",
    e = {"<cmd>lua require'sniprun'.run()<cr>", "run line"},
    i = {"<cmd>lua require'sniprun'.info()<cr>", "sniprun info"},
    r = {"<cmd>lua require'sniprun'.reset()<cr>", "reset sniprun"},
    r = {"<cmd>lua require'sniprun'.clear_repl()<cr>", "clear sniprun repl memory"},
    x = {"<cmd>lua require'sniprun.display'.close()<cr>", "close sniprun"},
    l = {"<cmd>lua require'sniprun.live_mode'.toggle()<cr>", "sniprun live mode toggle"},
    },
}, {
  mode = "n", 
  prefix = "<leader>"
})


wk.register({
  e = {
    name = "evaluate using sniprun",
    e = {"<cmd>lua require'sniprun'.run('v')<cr>", "run visual selection"},
  },
}, {
  mode = "v",
  prefix = "<leader>"
})

-- if vim.bo.filetype=="clojure" then
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
  }, { prefix = "<localleader>" })
-- elseif vim.bo.filetype=="java" then
  wk.register({
    j = {
      name = "jdtls",
      o = {"<cmd>lua require'jdtls'.organize_imports()<CR>","organize imports"},
      v = {"<cmd>lua require'jdtls'.extract_variable()<CR>","extract variable"},
      V = {"<cmd>lua require'jdtls'.extract_variable(true)<CR>","extract variable"},
      c = {"<cmd>lua require'jdtls'.extract_constant(true)<CR>","extract constant"},
      C = {"<cmd>lua require'jdtls'.extract_constant(true)<CR>","extract constant"},
      m = {"<cmd>lua require'jdtls'.extract_method(true)<CR>","extract method"},
      },
    d = {
      name = "jdtls debug",
      c = {"<cmd>lua require'jdtls'.test_class()<CR>","test class"},
      c = {"<cmd>lua require'jdtls'.test_nearest_method()<CR>","test nearest method"},
      },
  }, { prefix = "<localleader>" })
-- elseif vim.bo.filetype=="markdown" then
  wk.register({
    c = {
      name = "compile using pandoc",
      p = {":!pandoc<space>%<space>-o<space>%:r.pdf<CR>", "to pdf"},
      h = {":!pandoc<space>%<space>-o<space>%:r.html<CR>", "to html"},
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
  f = {
    name = "Telescope find",
    f = {"<cmd>Telescope find_files<cr>" , "find files"},
    g = {"<cmd>Telescope live_grep<cr>"  , "find with live grep"},
    b = {"<cmd>Telescope buffers<cr>"    , "find in buffers"},
    h = {"<cmd>Telescope help_tags<cr>"  , "help tags"},
    }
})