" vim: tabstop=2 shiftwidth=2 expandtab
"       _
"__   _(_)_ __ ___  _ __ ___
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__
"(_)_/ |_|_| |_| |_|_|  \___|
"

" Environment variables:
  set nocompatible
  syntax on
  filetype plugin indent on
  let mapleader=","
  let maplocalleader="-"
  set conceallevel=0
  set encoding=utf-8
  set number
  set relativenumber
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set clipboard=unnamedplus       " Allow for use of system-wide copy and paste functions
  set scrolloff=5             " Keep at least 3 lines above/below when scrolling
  set hlsearch              " Highlight search
  set noswapfile              " Don't use swap file
  set incsearch ignorecase        " Increase search
  set smartcase             " Override the 'ignorecase' option if the
                      " search pattern contains upper case characters.
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
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

" Autocommands and keyboard-shortcuts
  " German keyboard fix
  nmap ö '
  nmap ü [
  nmap ä ]
  nmap ß {
  " Mappings only available to patched terminals. See quoteme/st-nix
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
    " We need to remap some keys for remapping ctrl-w to work
    map <C-S-H> <cmd>:wincmd h<CR>
    map <C-S-J> <cmd>:wincmd k<CR>
    map <C-S-K> <cmd>:wincmd j<CR>
    map <C-S-L> <cmd>:wincmd l<CR>
  autocmd ColorScheme * highlight Conceal ctermfg=red ctermbg=0
  " Automatically deletes all tralling whitespace on save.
    " autocmd BufWritePre * %s/\s\+$//e
  " Disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  " Make 0 go to the first character rather than the beginning
  " " of the line. When we're programming, we're almost always
  " " interested in working with text rather than empty space. If
  " " you want the traditional beginning of line, use ^
    nnoremap 0 ^
    nnoremap ^ 0
  " Fix the go to next line if wrap is enabled
    nnoremap <expr> j v:count ? 'j' : 'gj'
    nnoremap <expr> k v:count ? 'k' : 'gk'
  " Return to last edit position when opening files (You want this!)
    augroup Remember_cursor_position
      autocmd!
      autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END
  " Show spaces as red if there's nothing after it (stole Greg Hurrel)
    augroup TrailWhiteSpaces
      highlight ColorColumn ctermbg=1
      autocmd BufWinEnter <buffer> match Error /\s\+$/
      autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
      autocmd InsertLeave <buffer> match Error /\s\+$/
      autocmd BufWinLeave <buffer> call clearmatches()
    augroup END


" ____  _               ____       _   _   _
"|  _ \| |_   _  __ _  / ___|  ___| |_| |_(_)_ __   __ _ ___
"| |_) | | | | |/ _` | \___ \ / _ \ __| __| | '_ \ / _` / __|
"|  __/| | |_| | (_| |  ___) |  __/ |_| |_| | | | | (_| \__ \
"|_|   |_|\__,_|\__, | |____/ \___|\__|\__|_|_| |_|\__, |___/
"               |___/                              |___/

" Twilight
lua << EOF
  require("twilight").setup {}
EOF

" nvim-colorizer.lua
lua require'colorizer'.setup()

" Split auto resizing
lua require("focus").setup()

" NeoScroll
lua require('neoscroll').setup()

" Marks.nvim
lua << EOF
require'marks'.setup {}
EOF

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

" FZF
" fun! s:openFileAtLocation(result)
"   if len(a:result) == 0
"     return
"   endif
"   let filePos = split(a:result, ':')
"   exec 'edit +' . l:filePos[1] . ' ' . l:filePos[0]
" endfun

" nnoremap <Leader>f :call fzf#run(fzf#wrap({
"   \ 'source': 'rg --line-number ''.*''',
"   \ 'options': '--delimiter : --preview "bat --style=plain --color=always {1} -H {2}" --preview-window "+{2}/2"',
"   \ 'sink': function('<sid>openFileAtLocation'),
"   \ }))<CR><enter>

" WhichKey
lua << EOF
require"mywhichkey"
EOF

" SnipRun
lua << EOF
require'sniprun'.setup({
  display = {
    "VirtualTextOk",
    "NvimNotify",
  }
})
EOF

" Copilot
lua << EOF
-- vim.schedule(function() require("copilot") end)
EOF

" cycle folds
lua << EOF
require('fold-cycle').setup({
  softwrap_movement_fix = false
})
EOF

" pretty-fold.nvim
lua << EOF
require('pretty-fold').setup()
require('pretty-fold.preview').setup()
EOF

" Neogen
lua << EOF
require('neogen').setup {}
require('neogen').setup({ snippet_engine = "luasnip" })
EOF

" Luasnip
lua require"myluasnip"

" Nvim-Cmp
set completeopt=menu,menuone,noselect
lua <<EOF
  local luasnip = require("luasnip")
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 's' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 's' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 's' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    -- Accept currently selected item. Set `select` to `false` to
    -- only confirm explicitly selected items.
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
      ['<Tab>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end),
    },
    sources = {
      { name = "copilot" },
      { name = 'nvim_lsp' },
      { name = 'cmp_pandoc' },
      { name = 'emoji' },
      { name = "latex_symbols" },
      -- { name = 'vsnip' }, -- For vsnip users
      -- { name = 'spell' }, -- disabled because it is cumbersome to use
      { name = 'luasnip' }, -- For luasnip users
      { name = 'buffer',
        option = {
          keyword_pattern = [[\k\+]],
        }
      },
      { name = 'path' },
    }
  })
require'pandoc'.setup()
require'cmp_pandoc'.setup({
  crossref = {
    enable_nabla = true
  }
})
EOF

" lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')
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
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- lsp-signature
  require "lsp_signature".on_attach()
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'texlab',
  'tsserver',
  'hls',
  'rnix',
  'jedi_language_server',
  'clojure_lsp',
  'rls',
  'clangd',
  'cmake',
  'ltex',
  'dartls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = {
      debounce_text_changes = 150,
    }
  }
end
-- nvim_lsp['java_language_server'].setup {
--   on_attach = on_attach,
--   capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
--   flags = {
--     debounce_text_changes = 150,
--   },
--   cmd = {"java-language-server"},
-- }
nvim_lsp['jdtls'].setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 150,
  },
  cmd = {vim.env.VIMRUNTIME .. "/jdt-language-server/bin/jdtls"},
}
-- sumneko_lua - Lua Language Server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
nvim_lsp['sumneko_lua'].setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
EOF

" Vimspector
" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
" FIX: this currently needs to be installed using `./install_gadget.py --basedir $HOME/.vim/vimspector-config --all --force-all`
let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )
" let g:vimspector_base_dir='/home/luca/.vim/vimspector-config'

" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- disable = function(lang, bufnr) -- Disable in python because this is currently broken TODO fix this
    --   return lang == "python" or lang == "vim"
    -- end,
  },
  rainbow = { -- nvim-ts-rainbow
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}
EOF

" todo-comments
lua << EOF
  require("todo-comments").setup {
    signs = false,
  }
EOF

" gitsigns.nvim
lua << EOF
require('gitsigns').setup()
EOF

" code action sign collumn
lua << EOF
require'nvim-lightbulb'.setup({
  sign = {
    enabled = true
  },
  status_text = {
    enabled = true,
    text = "",
    text_unavailable = ""
  }
})
EOF
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

" colorscheme
  colorscheme onedark

" markdown
  let g:vim_markdown_folding_disabled = 1

" vim-slime
  let g:slime_target = "neovim"
  let g:slime_no_mappings = 1

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

" nvim-jdtls
lua <<EOF
-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '~/.jdtls-workspace/' .. project_name
require('jdtls').start_or_attach({
  cmd = {
    -- 💀
    'java', 
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    -- 💀
    '-jar', vim.env.VIMRUNTIME .. '/jdt-language-server/bin/jdtls',
    -- 💀
    '-configuration', vim.env.VIMRUNTIME .. '/jdt-language-server/config_linux',
    -- 💀
    '-data', workspace_dir
    },
  init_options = {
    bundles = {
      vim.fn.glob("~/.vim/vimspector-config/gadgets/linux/vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar")
    }
  },
})
EOF

" vim2hs
  "let g:haskell_conceal_wide = 1
  let g:haskell_indent_disable=1
  let g:haskell_classic_highlighting=1

" delimitMate
  let delimitMate_expand_space=1
  let delimitMate_expand_cr=1

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

" latex-unicoder.vim
  let g:unicoder_cancel_normal = 1
  let g:unicoder_cancel_insert = 1
  let g:unicoder_cancel_visual = 1
  nnoremap <C-l> :call unicoder#start(0)<CR>
  inoremap <C-l> <Esc>:call unicoder#start(1)<CR>
  vnoremap <C-l> :<C-u>call unicoder#selection()<CR>

" ____       _   _   _
"/ ___|  ___| |_| |_(_)_ __   __ _ ___
"\___ \ / _ \ __| __| | '_ \ / _` / __|
" ___) |  __/ |_| |_| | | | | (_| \__ \
"|____/ \___|\__|\__|_|_| |_|\__, |___/
"                            |___/

" build nix projects
  map <F9> :!nix build<enter>

" neotree file browsing
  nnoremap <F1> :Neotree filesystem toggle left<CR>
" symbols-outline code browsing
  nnoremap <F2> :SymbolsOutline<CR>
" todo-comments
  nnoremap <F3> :TodoTelescope<CR>

" Sage
  autocmd FileType sage set syntax=python

" GO
  autocmd FileType go noremap <F9> <ESC>:GoRun<enter>

" C
  autocmd FileType c setlocal tabstop=2
  autocmd FileType c setlocal shiftwidth=2
  autocmd FileType c setlocal expandtab

" HASKELL
  autocmd FileType haskell setlocal tabstop=2
  autocmd FileType haskell setlocal shiftwidth=2
  autocmd FileType haskell setlocal expandtab
  autocmd FileType cabal setlocal tabstop=2
  autocmd FileType cabal setlocal shiftwidth=2
  autocmd FileType cabal setlocal expandtab

" Nix
  autocmd FileType nix setlocal tabstop=2
  autocmd FileType nix setlocal shiftwidth=2
  autocmd FileType nix setlocal expandtab

" LaTex
  autocmd FileType tex map <F9> :!pdflatex<space>%<enter>

" RMARKDOWN
  " If it is a bookdown book
  if filereadable("_build.sh")
    autocmd FileType rmarkdown map <F9> :!./_build.sh<enter>
  " Otherwise
  else
    autocmd FileType rmarkdown map <F9> :!Rscript<space>-e<space>'library(rmarkdown);render("%")'<enter>
  endif
  autocmd FileType rmadkdown setlocal expandtab
" MARKDOWN
  autocmd FileType markdown setlocal expandtab
  autocmd FileType markdown map <F9> :!grep -q "output_format: html" % && pandoc % -o %:r.pdf \|\| pandoc % -o %:r.pdf<enter>

" " CLOJURE
"   autocmd FileType clojure :Lein

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
