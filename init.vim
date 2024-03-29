" vim: tabstop=2 shiftwidth=2 expandtab foldmethod=marker
"       _
"__   _(_)_ __ ___  _ __ ___
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__
"(_)_/ |_|_| |_| |_|_|  \___|
"

" {{{
" Environment variables:
  set nocompatible
  syntax enable
  let mapleader=","
  let maplocalleader="-"
  set conceallevel=0
  set encoding=utf-8
  set number
  set relativenumber
  set tabstop=2
  set shiftwidth=2
  set expandtab
  filetype plugin indent on
  set clipboard=unnamedplus " Allow for use of system-wide copy and paste functions
  set scrolloff=5           " Keep at least 3 lines above/below when scrolling
  set hlsearch              " Highlight search
  set noswapfile            " Don't use swap file
  set incsearch ignorecase  " Increase search
  set smartcase             " Override the 'ignorecase' option if the
                            " search pattern contains upper case characters.
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set nofoldenable
  " set foldtext=substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend))
  " set fillchars=fold:\ 
  " set foldnestmax=3
  " set foldminlines=1
  " set foldmethod=manual
  set mouse=a
  set undofile undodir=~/.vim/tmp/undo/ " Set undofiles (undo files even if you exited the file)
  set splitbelow              " Splits open at the bottom and right
  set splitright
  set wildmode=longest,list,full      " Enable autocompletion:
  set wildmenu
  set lazyredraw              " redraw only when we need to.
  set colorcolumn=72            " limit the text input
  set spell spelllang=en_us,de_de     " spellchecker
  set termguicolors             " true color support
" }}}

" ____  _               ____       _   _   _
"|  _ \| |_   _  __ _  / ___|  ___| |_| |_(_)_ __   __ _ ___
"| |_) | | | | |/ _` | \___ \ / _ \ __| __| | '_ \ / _` / __|
"|  __/| | |_| | (_| |  ___) |  __/ |_| |_| | | | | (_| \__ \
"|_|   |_|\__,_|\__, | |____/ \___|\__|\__|_|_| |_|\__, |___/
"               |___/                              |___/

" {{{

" {{{
" Telescope
lua << EOF
local telescope = require('telescope')
telescope.setup()

telescope.load_extension('hoogle')
EOF
" }}}

" {{{
" gesture.nvim
lua << EOF
vim.keymap.set("n", "<LeftDrag>", [[<Cmd>lua require("gesture").draw()<CR>]], { silent = true })
vim.keymap.set("n", "<LeftRelease>", [[<Cmd>lua require("gesture").finish()<CR>]], { silent = true })

-- TODO: make scrolling work
local gesture = require("gesture")
gesture.register({
  name = "scroll up",
  inputs = { gesture.up() },
  action = "normal <c-u>",
})
gesture.register({
  name = "scroll down",
  inputs = { gesture.down() },
  action = "normal <c-d>",
})
gesture.register({
  name = "scroll to bottom",
  inputs = { gesture.up(), gesture.down() },
  action = "normal! G",
})
gesture.register({
  name = "scroll to top",
  inputs = { gesture.down(), gesture.up() },
  action = "normal! gg",
})
gesture.register({
  name = "next tab",
  inputs = { gesture.right() },
  action = "tabnext",
})
gesture.register({
  name = "previous tab",
  inputs = { gesture.left() },
  action = function(ctx) -- also can use callable
    vim.cmd.tabprevious()
  end,
})
gesture.register({
  name = "go back",
  inputs = { gesture.right(), gesture.left() },
  -- map to `<C-o>` keycode
  action = [[lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>", true, false, true), "n", true)]],
})
EOF
" }}}

" {{{
" Twilight
lua << EOF
  require("twilight").setup {}
EOF
" }}}

" {{{
" nvim-colorizer.lua
lua require'colorizer'.setup()
" }}}

" {{{
" Split auto resizing
lua require("focus").setup()
" }}}

" {{{
" NeoScroll
lua require('neoscroll').setup()
" }}}

" {{{ Codewindow
lua <<EOF
local codewindow = require('codewindow')
codewindow.setup()
--codewindow.apply_default_keybinds()
EOF
" }}}

" {{{
" Marks.nvim
lua << EOF
require'marks'.setup {}
EOF
" }}}

" {{{
" indent-blankline.nvim
lua << EOF
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF
" }}}

" {{{
" WhichKey
:luafile $RUNTIME_EXTRA/lua/mywhichkey.lua
" }}}

" {{{
" SnipRun
lua << EOF
require'sniprun'.setup({
  display = {
    "VirtualTextOk",
    "NvimNotify",
  }
})
EOF
" }}}

" {{{
" Copilot
lua << EOF
vim.api.nvim_set_var("copilot_filetypes", {
      ["dap-repl"] = false,
})
require("copilot").setup({
  filetypes = {
    markdown = true,
    ["."] = true
  },
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-S-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-CR>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
})
-- vim.schedule(function() require("copilot") end)
-- make <c-i> trigger 'require("copilot.suggestion").accept()', but only if
-- `require("copilot.suggestion").is_visible()` is true
vim.api.nvim_set_keymap("i", "<c-i>", "<cmd>lua if require('copilot.suggestion').is_visible() then require('copilot.suggestion').accept() else vim.fn.feedkeys('\t', 'n') end<CR>", { noremap = true, silent = true })

-- Toggle Copilot using <ctrl><alt><shift>O
vim.api.nvim_set_keymap("n", "<M-C-O>", "<cmd>Copilot toggle<CR>", { noremap = true, silent = true })
EOF
" inoremap <m-cr> <cmd>lua require("copilot.suggestion").accept()<CR>
" }}}

" {{{
" cycle folds
lua << EOF
require('fold-cycle').setup({
  softwrap_movement_fix = false
})
EOF
inoremap <c-+> <cmd>lua require('fold-cycle').open()<CR>
nnoremap <c-+> <cmd>lua require('fold-cycle').open()<CR>
inoremap <c--> <cmd>lua require('fold-cycle').close()<CR>
nnoremap <c--> <cmd>lua require('fold-cycle').close()<CR>
inoremap <s-c-+> <cmd>lua require('fold-cycle').open_all()<CR>
nnoremap <s-c-+> <cmd>lua require('fold-cycle').open_all()<CR>
inoremap <s-c--> <cmd>lua require('fold-cycle').close_all()<CR>
nnoremap <s-c--> <cmd>lua require('fold-cycle').close_all()<CR>
" }}}

" {{{
"Symbols outline
lua require("symbols-outline").setup()
" }}}

" {{{
" pretty-fold.nvim
lua << EOF
require('pretty-fold').setup()
require('fold-preview').setup()
EOF
" }}}

" {{{
" nvim-web-devicons
lua << EOF
require'nvim-web-devicons'.setup {
  override = {
    html = {
      icon = "",
      color = "#DE8C92",
      name = "html"
    },
    css = {
      icon = "",
      color = "#61afef",
      name = "css"
    },
    js = {
      icon = "",
      color = "#EBCB8B",
      name = "js"
    },
    ts = {
      icon = "ﯤ",
      color = "#519ABA",
      name = "ts"
    },
    kt = {
      icon = "󱈙",
      color = "#F18E33",
      name = "kt"
    },
    png = {
      icon = " ",
      color = "#BD77DC",
      name = "png"
    },
    jpg = {
      icon = " ",
      color = "#BD77DC",
      name = "jpg"
    },
    jpeg = {
      icon = " ",
      color = "#BD77DC",
      name = "jpeg"
    },
    mp3 = {
      icon = "",
      color = "#C8CCD4",
      name = "mp3"
    },
    mp4 = {
      icon = "",
      color = "#C8CCD4",
      name = "mp4"
    },
    out = {
      icon = "",
      color = "#C8CCD4",
      name = "out"
    },
    Dockerfile = {
      icon = "",
      color = "#b8b5ff",
      name = "Dockerfile"
    },
    rb = {
      icon = "",
      color = "#701516",
      name = "rb"
    },
    vue = {
      icon = "﵂",
      color = "#4FC08D",
      name = "vue"
    },
    py = {
      icon = "",
      color = "#a1b56c",
      name = "py"
    },
    toml = {
      icon = "",
      color = "#61afef",
      name = "toml"
    },
    lock = {
      icon = "",
      color = "#bd93f9",
      name = "lock"
    },
    zip = {
      icon = "",
      color = "#e0af68",
      name = "zip"
    },
    xz = {
      icon = "",
      color = "#e0af68",
      name = "xz"
    },
    deb = {
      icon = "",
      color = "#a3b8ef",
      name = "deb"
    },
    rpm = {
      icon = "",
      color = "#e45649",
      name = "rpm"
    },
    ["7z"] = {
      icon = "",
      color = "#e0af68",
      name = "7z"
    },
    rar = {
      icon = "",
      color = "#e0af68",
      name = "rar"
    },
    nix = {
      icon = "",
      color = "#7e7eff",
      name = "nix"
    },
  };
  color_icons = true;
  default = true;
}
EOF
" }}}

" {{{
" Neogen
lua << EOF
require('neogen').setup {}
require('neogen').setup({ snippet_engine = "luasnip" })
EOF
" }}}

" {{{
" Luasnip
:luafile $RUNTIME_EXTRA/lua/myluasnip.lua
" }}}

" {{{ indent-tools.nvim
lua <<EOF
require("indent-tools").config({})
EOF
" }}}

" {{{
" Nvim-Cmp
set completeopt=menu,menuone,noselect
lua <<EOF
  -- {{{ Imports
  local cmp = require'cmp'
  require("lspsaga").setup({})
  local lspkind = require('lspkind')
  local luasnip = require("luasnip")
  -- }}}
  -- {{{ Setup nvim-cmp.
  cmp.setup({
    -- {{{ Snippet
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users
      end,
    },
    -- }}}
    -- {{{ Mapping
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 's' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 's' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 's' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end),
      ['<S-C-CR>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end),
      ['<M-S-Tab>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end),
    },
    -- }}}
    -- {{{ Sources
    sources = {
      -- { name = "copilot" },
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users
      { name = "latex_symbols" },
      { name = 'nvim_lua' },
      { name = "greek" },
      { name = 'cmp_pandoc' },
      { name = 'path' },
      { name = 'buffer',
        option = {
          keyword_pattern = [[\k\+]],
        }
      },
      { name = 'rg', keyword_length = 3},
      -- { name = 'dictionary', keyword_length = 4 },
      { name = 'emoji' },
      -- { name = 'spell',
      --   option = {
      --     keep_all_entries = false,
      --     enable_in_context = function()
      --       return require('cmp.config.context').in_treesitter_capture('spell')
      --     end,
      --   },
      --  }, -- Disabled because cmp-dictionary works
    },
    -- }}}
    -- {{{ Window
    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
    },
    -- }}}
    -- {{{ Formatting
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "    (" .. strings[2] .. ")"

        return kind
      end,
    },
    -- }}}
  })
  -- }}}
  -- {{{ Setup CMDline
  -- {{{ : commands
  cmp.setup.cmdline(':', {
    sources = {
      -- { name = 'cmdline_history' },
      { name = 'path' },
      { name = 'cmdline' },
    },
    mapping = cmp.mapping.preset.cmdline(),
  })
  -- }}}
  -- {{{ / commands
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'nvim_lsp_document_symbol' },
      { name = 'buffer' },
      { name = 'cmdline_history' },
    },
    mapping = cmp.mapping.preset.cmdline(),
  })
  -- }}}
  --}}}

-- {{{ Setup cmp-dictionary

require("cmp_dictionary").setup({
	dic = {
		spelllang = {
			en_us = vim.env.RUNTIME_EXTRA .. "/dictionaries/en.dict",
			de_de = vim.env.RUNTIME_EXTRA .. "/dictionaries/de.dict",
		},
	},
})
-- }}}

  -- {{{ Pandoc / Nabla
require'pandoc'.setup()
require'cmp_pandoc'.setup({
  crossref = {
    enable_nabla = true
  }
})
-- }}}
EOF
" }}}

" {{{
" trouble.nvim
lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
" }}}

" {{{
" {{{ Package managers / Mason
lua << EOF
require("mason").setup() 
require("mason-null-ls").setup({
  automatic_setup = true,
})
require("mason-nvim-dap").setup({
    automatic_setup = true,
})
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function ()
    require("rust-tools").setup {}
    end
}
EOF
" }}}
" lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')
local navic = require("nvim-navic")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- lsp-signature
  require "lsp_signature".on_attach()
  -- nvim-navic
  navic.attach(client, bufnr)
end

local servers = {
  'bashls',
  'hls',
  'rnix',
  'texlab',
  'vimls',
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      offsetEncoding = "utf-8",
    },
  }
end
EOF
" }}}

" {{{
" Vimspector
" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
" FIX: this currently needs to be installed using `./install_gadget.py --basedir $HOME/.vim/vimspector-config --all --force-all`
let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )
" let g:vimspector_base_dir='/home/luca/.vim/vimspector-config'
" }}}

"{{{ vim-markdown
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_conceal_code_blocks = 0
""}}}

" {{{
" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  parser_install_dir = "~/.config/treesitter_parsers",
  -- ensure_installed = "all",
  highlight = {
    enable = true,
    disable = {"dart"},
  },
  rainbow = { -- nvim-ts-rainbow
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  }
}
vim.opt.runtimepath:append("~/.config/treesitter_parsers")

require'treesitter-context'.setup{}

-- treesitter-unit
vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})
EOF
" }}}

" {{{
" todo-comments
lua << EOF
  require("todo-comments").setup {
    signs = false,
  }
EOF
" }}}

" {{{
" gitsigns.nvim
lua << EOF
require('gitsigns').setup()
EOF
" }}}

" {{{
" code action sign collumn
lua << EOF
require'nvim-lightbulb'.setup({
  autocmd = {enabled = true},
  sign = {
    enabled = true,
    priority = 10,
  },
  status_text = {
    enabled = true,
    text = "💡",
    text_unavailable = ""
  }
})
EOF
" }}}

" {{{
" colorscheme
" colorscheme onedark
let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
lua << EOF
require("catppuccin").setup({
  highlight_overrides = {
    all = function(colors)
    return {
      NvimTreeNormal = { fg = colors.none },
      CmpBorder = { fg = "#a0a0a0" },
    }
    end
  },
  integrations = {
    aerial          = true,
    barbar          = true,
    cmp             = true,
    gitsigns        = true,
    neotest         = true,
    neotree         = true,
    lsp_trouble     = true,
    notify          = true,
    symbols_outline = true,
    treesitter      = true,
    ts_rainbow      = true,
    which_key       = true,
  }
  })
EOF
colorscheme catppuccin
" }}}

" {{{
" markdown
let g:vim_markdown_folding_disabled = 1
" }}}

" {{{
" vim-slime
let g:slime_target = "neovim"
let g:slime_no_mappings = 1
" }}}

" {{{
" Grammarous settings
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#use_vim_spelllang = 1
let g:grammarous#default_comments_only_filetypes = {
      \ '*' : 1, 'help' : 0, 'markdown' : 0,
      \ }
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
  nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
  nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
  nunmap <buffer><C-n>
  nunmap <buffer><C-p>
endfunction
" }}}

" {{{
" vim2hs
"let g:haskell_conceal_wide = 1
let g:haskell_indent_disable=1
let g:haskell_classic_highlighting=1
" }}}

" {{{
" delimitMate
let delimitMate_expand_space=1
let delimitMate_expand_cr=1
" }}}

" {{{
" vim-skeleton
let g:skeleton_replacements = {}
function! g:skeleton_replacements.DATE()
  return strftime("%Y-%m-%d %a %H:%M %S")
endfunction
function! g:skeleton_replacements.BASENAMECAPITAL()
  return toupper(expand('%:t:r'))
endfunction
function! g:skeleton_replacements.FOLDERNAME()
  return expand('%:p:h:t')
endfunction
function! g:skeleton_replacements.AUTHOR()
  return "Luca Leon Happel"
endfunction
" }}}

" {{{
" latex-unicoder.vim
let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1
nnoremap <C-l> :call unicoder#start(0)<CR>
inoremap <C-l> <Esc>:call unicoder#start(1)<CR>
vnoremap <C-l> :<C-u>call unicoder#selection()<CR>
" }}}
" }}}

" ____       _   _   _
"/ ___|  ___| |_| |_(_)_ __   __ _ ___
"\___ \ / _ \ __| __| | '_ \ / _` / __|
" ___) |  __/ |_| |_| | | | | (_| \__ \
"|____/ \___|\__|\__|_|_| |_|\__, |___/
"                            |___/

" {{{
" Autocommands and keyboard-shortcuts
  " Nix flake hack (so neovim loads buffers correctly when opening a file from a command line arg)
  autocmd VimEnter ?* :e
  " {{{ Code action on alt-enter like intellij
  inoremap <a-.> <esc>:CodeActionMenu<CR>
  nnoremap <a-.> <esc>:CodeActionMenu<CR>
  inoremap <a-CR> <esc>:Lspsaga code_action<CR>
  nnoremap <a-CR> <esc>:Lspsaga code_action<CR>
  inoremap <a-b> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <a-b> <cmd>lua vim.lsp.buf.definition()<CR>
  " }}}
  " {{{ Simple keymap finding
  inoremap <a-k> <esc>:Telescope keymaps<CR>
  nnoremap <a-k> <esc>:Telescope keymaps<CR>
  " }}}
  " {{{
  " German keyboard fix
  nmap ö '
  nmap ü [
  nmap ä ]
  nmap ß {
  "}}}
  " {{{
  " {{{
  " Mappings only available to patched terminals. See quoteme/st-nix{{{
  map <C-Tab> <cmd>BufferNext<CR>
  map <C-S-Tab> <cmd>BufferPrevious<CR>
  map <M-Tab> <cmd>BufferMoveNext<CR>
  map <M-S-Tab> <cmd>BufferMovePrevious<CR>
  map <C-W> <cmd>BufferClose<CR>
  map <C-S-W> <cmd>BufferClose!<CR>
  inoremap <C-Tab> <cmd>BufferNext<CR><ESC>
  inoremap <C-S-Tab> <cmd>BufferPrevious<CR><ESC>
  inoremap <M-Tab> <cmd>BufferMoveNext<CR><ESC>
  inoremap <M-S-Tab> <cmd>BufferMovePrevious<CR><ESC>
  inoremap <C-W> <cmd>BufferClose<CR><ESC>
  inoremap <C-S-W> <cmd>BufferClose!<CR>
  tnoremap <C-Tab> <cmd>BufferNext<CR><ESC>
  tnoremap <C-S-Tab> <cmd>BufferPrevious<CR><ESC>
  tnoremap <M-Tab> <cmd>BufferMoveNext<CR><ESC>
  tnoremap <M-S-Tab> <cmd>BufferMovePrevious<CR><ESC>
  tnoremap <C-W> <cmd>BufferClose<CR><ESC>
  tnoremap <C-S-W> <cmd>BufferClose!<CR>
  " }}}

  " {{{
    " We need to remap some keys for remapping ctrl-w to work
    map <C-S-H> <cmd>:wincmd h<CR>
    map <C-S-J> <cmd>:wincmd k<CR>
    map <C-S-K> <cmd>:wincmd j<CR>
    map <C-S-L> <cmd>:wincmd l<CR>
    tnoremap <C-S-H> <cmd>:wincmd h<CR>
    tnoremap <C-S-J> <cmd>:wincmd k<CR>
    tnoremap <C-S-K> <cmd>:wincmd j<CR>
    tnoremap <C-S-L> <cmd>:wincmd l<CR>
    " }}}
  " }}}
  " {{{
  " Save and restore view (including folds) automatically
    autocmd BufWritePost,BufLeave,WinLeave,BufWinLeave ?* mkview!
    autocmd BufWinEnter ?* silent! loadview
  " }}}
  " {{{
  " Disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  " }}}
  " {{{
  " Make 0 go to the first character rather than the beginning
  " " of the line. When we're programming, we're almost always
  " " interested in working with text rather than empty space. If
  " " you want the traditional beginning of line, use ^
    nnoremap 0 ^
    nnoremap ^ 0
  " }}}
  " {{{
  " Fix the go to next line if wrap is enabled
    nnoremap <expr> j v:count ? 'j' : 'gj'
    nnoremap <expr> k v:count ? 'k' : 'gk'
  " }}}
  " {{{
  " Return to last edit position when opening files (You want this!)
    augroup Remember_cursor_position
      autocmd!
      autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END
  " }}}
  " {{{
  " Show spaces as red if there's nothing after it (stole Greg Hurrel)
    augroup TrailWhiteSpaces
      highlight ColorColumn ctermbg=1
      autocmd BufWinEnter <buffer> match Error /\s\+$/
      autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
      autocmd InsertLeave <buffer> match Error /\s\+$/
      autocmd BufWinLeave <buffer> call clearmatches()
    augroup END
  " }}}

" {{{
" neotree file browsing
nnoremap <F1> :Neotree filesystem toggle left reveal<CR>
" }}}
" {{{
" symbols-outline code browsing
  nnoremap <F2> :SymbolsOutline<CR>
" }}}
" {{{
" todo-comments
  nnoremap <F3> :TodoTelescope<CR>
" }}}

" {{{
" Sage
autocmd FileType sage set syntax=python set ft=python
" }}}
" {{{
" Python
autocmd FileType python set autoindent
" }}}
" {{{
" GO
autocmd FileType go noremap <F9> <ESC>:GoRun<enter>
" }}}
" {{{
" C
autocmd FileType c setlocal tabstop=2
autocmd FileType c setlocal shiftwidth=2
autocmd FileType c setlocal expandtab
" }}}
" {{{
" HASKELL
autocmd BufReadPost xmonad.hs setlocal modeline
autocmd FileType haskell setlocal tabstop=2
autocmd FileType haskell setlocal shiftwidth=2
autocmd FileType haskell setlocal expandtab
autocmd FileType cabal setlocal tabstop=2
autocmd FileType cabal setlocal shiftwidth=2
autocmd FileType cabal setlocal expandtab
" }}}
" {{{
" Nix
autocmd FileType nix setlocal tabstop=2
autocmd FileType nix setlocal shiftwidth=2
autocmd FileType nix setlocal expandtab
  " {{{
  " build nix projects
  map <F9> :!nix build<enter>
  " }}}
" }}}
" {{{
" LaTex
autocmd FileType tex map <F9> :!pdflatex<space>%<enter>
" }}}
" {{{
" RMarkdown
  " If it is a bookdown book
  if filereadable("_build.sh")
    autocmd FileType rmarkdown map <F9> :!./_build.sh<enter>
  " Otherwise
  else
    autocmd FileType rmarkdown map <F9> :!Rscript<space>-e<space>'library(rmarkdown);render("%")'<enter>
  endif
  autocmd FileType rmadkdown setlocal expandtab
  " }}}
" {{{
" Markdown
  autocmd FileType markdown setlocal expandtab
  autocmd FileType markdown map <F9> :!grep -q "output_format: html" % && pandoc % -o %:r.pdf \|\| pandoc % -o %:r.pdf<enter>
" }}}
" {{{
" Clojure
" autocmd FileType clojure :Lein
" }}}
" {{{
" Java
autocmd FileType java setlocal tabstop=2
autocmd FileType java setlocal shiftwidth=2
autocmd FileType java setlocal expandtab
autocmd FileType groovy setlocal tabstop=2
autocmd FileType groovy setlocal shiftwidth=2
autocmd FileType groovy setlocal expandtab
autocmd FileType kotlin setlocal tabstop=2
autocmd FileType kotlin setlocal shiftwidth=2
autocmd FileType kotlin setlocal expandtab
" }}}
" }}}

:luafile $RUNTIME_EXTRA/lua/mysettings.lua
:luafile $RUNTIME_EXTRA/lua/myplugins.lua
