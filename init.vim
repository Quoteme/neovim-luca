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
  set tabstop=4
  set shiftwidth=4
  set clipboard=unnamedplus       " Allow for use of system-wide copy and paste functions
  set scrolloff=5             " Keep at least 3 lines above/below when scrolling
  set hlsearch              " Highlight search
  set noswapfile              " Don't use swap file
  set incsearch ignorecase        " Increase search
  set smartcase             " Override the 'ignorecase' option if the
                      " search pattern contains upper case characters.
  " set foldmethod=expr
  " set foldexpr=nvim_treesitter#foldexpr()
  " set foldtext=substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend))
  " set fillchars=fold:\ 
  " set foldnestmax=3
  " set foldminlines=1
  set foldmethod=manual
  set mouse=a
  set undofile undodir=~/.vim/tmp/undo/ " Set undofiles (undo files even if you exited the file)
  set splitbelow              " Splits open at the bottom and right
  set splitright
  set wildmode=longest,list,full      " Enable autocompletion:
  set wildmenu
  set lazyredraw              " redraw only when we need to.
  set colorcolumn=72            " limit the text input
  set nospell spelllang=en_us,de_de     " spellchecker
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
  map <M-Tab> <cmd>BufferMovePrevious<CR>
  map <M-S-Tab> <cmd>BufferMoveNext<CR>
  map <C-W> <cmd>BufferClose<CR>
    " We need to remap some keys for remapping ctrl-w to work
    map <C-S-H> <cmd>:wincmd h<CR>
    map <C-S-J> <cmd>:wincmd k<CR>
    map <C-S-K> <cmd>:wincmd j<CR>
    map <C-S-L> <cmd>:wincmd l<CR>
  " Fix ugly red backgrounds TODO is this still needed?
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

if vim.bo.filetype=="clojure" then
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
elseif vim.bo.filetype=="markdown" then
  wk.register({
    c = {
      name = "compile using pandoc",
      p = {":!pandoc<space>%<space>-o<space>%:r.pdf<CR>", "to pdf"},
      h = {":!pandoc<space>%<space>-o<space>%:r.html<CR>", "to html"},
      },
  }, { prefix = "<localleader>" })
end
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

" Luasnip
lua <<EOF
-- Load VSCode like snippets from external plugins
require("luasnip.loaders.from_vscode").lazy_load()

-- Custom snippets
local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d')} end

-- Markdown
ls.filetype_extend("markdown",{"latex", "plaintext"})
ls.add_snippets("markdown",{
  -- meta data
  snip({
    trig="meta",
    name="YAML Metadata",
    dscr="YAML metadata format for markdown",
    },{
    text({"---",
    "title: "}), insert(1, "note_title"), text({"", 
    "author: "}), insert(2, "author"), text({"", 
    "date: "}), func(date, {}), text({"",
    "categories: ["}), insert(3, ""), text({"]",
    "lastmod: "}), func(date, {}), text({"",
    "tags: ["}), insert(4), text({"]",
    "lang: "}), insert(5), text({"",
    "header-includes: ","  - \\usepackage{amsthm}","  - "}), insert(6), text({"",
    "comments: true",
    "---", ""}),
    insert(0)
  }),
  -- math mode
  snip({
    trig="mi",
    name="inline math",
    dscr="inline math using $ ... $",
    },{
    text({"$"}),
    insert(1),
    text({"$"}),
  }),
  snip({
    trig="mn",
    name="new line math",
    dscr="new line math using $$ ... $$",
    },{
    text({"","$$"}),
    insert(1),
    text({"$$",""}),
  }),
  snip({
    trig="aligned",
    name="aligned math environment",
    dscr="\\begin{aligned} ... \\end{aligned}",
    },{
    text({"\\begin{aligned}"}),
    insert(1),
    text({" &= "}),
    insert(2),
    text({" \\\\"}),
    insert(3),
    text({" &= "}),
    insert(4),
    text({"\\end{aligned}"}),
  }),
  snip({
    trig="set",
    name="set",
    dscr="\\{ ... | ... \\}",
    },{
    text({"\\{ "}),
    insert(1),
    text({" | "}),
    insert(2),
    text({" \\}"}),
  }),
  snip({
    trig="_",
    name="subscript",
    dscr="..._{ ... }",
    },{
    text({"_{"}),
    insert(1),
    text({"}"}),
  }),
  snip({
    trig="^",
    name="supscript",
    dscr="...^{ ... }",
    },{
    text({"^{"}),
    insert(1),
    text({"}"}),
  }),
  snip({
    trig="frac",
    name="fraction",
    dscr="\\frac{ ... }{ ... }\n\n x \n---\n y ",
    },{
    text({"\\frac{"}),
    insert(1),
    text({"}{"}),
    insert(2),
    text({"}"}),
  }),
  -- Letters
  snip({
    trig="cal",
    name="mathcal",
    dscr="\\mathcal{...}",
    },{
    text({"\\mathcal{"}),
    insert(1),
    text({"}"}),
  }),
  snip({
    trig="bb",
    name="mathbb",
    dscr="\\mathbb{...}",
    },{
    text({"\\mathbb{"}),
    insert(1),
    text({"}"}),
  }),
  -- arrows
  snip({
    trig="arrowright",
    name="→",
    dscr="\\rightarrow",
    },{
    text({"\\rightarrow"}),
  }),
  snip({
    trig="arrowleft",
    name="←",
    dscr="\\leftarrow",
    },{
    text({"\\leftarrow"}),
  }),
  snip({
    trig="arrowrightlong",
    name="⟶",
    dscr="\\longrightarrow",
    },{
    text({"\\longrightarrow"}),
  }),
  snip({
    trig="arrowleftlong",
    name="⟵",
    dscr="\\longleftarrow",
    },{
    text({"\\longleftarrow"}),
  }),
  snip({
    trig="implicate",
    name="⇒",
    dscr="\\Rightarrow",
    },{
    text({"\\Rightarrow"}),
  }),
  snip({
    trig="iff",
    name="⇔",
    dscr="\\Leftrightarrow",
    },{
    text({"\\Leftrightarrow"}),
  }),
  -- brackets
  snip({
    trig="<",
    name="〈 ... 〉",
    dscr="\\langle ... \\rangle\n<...>",
    },{
    text({"\\langle "}),
    insert(1),
    text({" \\rangle"}),
  }),
  snip({
    trig="<size",
    name="〈 ... 〉",
    dscr="\\langle ... \\rangle\n/     \\\n| ... |\\n\\     /",
    },{
    text({"\\langle "}),
    insert(1),
    text({" \\rangle"}),
  }),
  snip({
    trig="(",
    name="\\left( ... \\right)",
    dscr="\\left( ... \\right)",
    },{
    text({"\\left("}),
    insert(1),
    text({"\\right)"}),
  }),
  -- bra-ket notation
  snip({
    trig="bra",
    name="< ... |",
    dscr="\\langle ... |",
    },{
    text({"\\langle "}),
    insert(1),
    text({" |"}),
  }),
  snip({
    trig="ket",
    name="| ... >",
    dscr="| ... \\rangle",
    },{
    text({"| "}),
    insert(1),
    text({" \\rangle"}),
  }),
  snip({
    trig="braket",
    name="< ... | ... >",
    dscr="\\langle ... | ... \\rangle",
    },{
    text({"\\langle "}),
    insert(1),
    text({" | "}),
    insert(2),
    text({" \\rangle"}),
  }),
  -- amsthm support
  snip({
    trig="def",
    name="Definition",
    dscr="amsthm definition block",
    },{
    text({"\\begin{definition}",""}),
    insert(1),
    text({"","\\end{definition}"}),
  }),
  snip({
    trig="thm",
    name="Theorem",
    dscr="amsthm theorem block",
    },{
    text({"\\begin{theorem}",""}),
    insert(1),
    text({"","\\end{theorem}"}),
  }),
  snip({
    trig="prop",
    name="Proposition",
    dscr="amsthm proposition block",
    },{
    text({"\\begin{proposition}",""}),
    insert(1),
    text({"","\\end{proposition}"}),
  }),
  snip({
    trig="lem",
    name="Lemmata",
    dscr="amsthm lemmata block",
    },{
    text({"\\begin{lemmata}",""}),
    insert(1),
    text({"","\\end{lemmata}"}),
  }),
  snip({
    trig="cor",
    name="Corollary",
    dscr="amsthm corollary block",
    },{
    text({"\\begin{corollary}",""}),
    insert(1),
    text({"","\\end{corollary}"}),
  }),
  -- dots
  snip({
    trig="*",
    name="cdot",
    dscr="·",
    },{
    text({"\\cdot"}),
  }),
  snip({
    trig="...",
    name="dots",
    dscr="...",
    },{
    text({"\\dots"}),
  }),
  snip({
    trig="...",
    name="diagonal dots",
    dscr="·\n ·\n  ·",
    },{
    text({"\\ddots"}),
  }),
  snip({
    trig="...",
    name="vertical dots",
    dscr="·\n·\n·",
    },{
    text({"\\vdots"}),
  }),
  -- Matrix
  snip({
    trig="matrix2x2",
    name="matrix 2x2",
    dscr="a11 a12\na21 a22",
    },{
    text({"\\begin{array}{cc}",""}),
    insert(1, "a_{11}"),
    text({" & "}),
    insert(2, "a_{12}"),
    text({" \\\\",""}),
    insert(3, "a_{21}"),
    text({" & "}),
    insert(4, "a_{22}"),
    text({" \\\\",""}),
    text({"\\end{array}"}),
  }),
  snip({
    trig="matrix3x3",
    name="matrix 3x3",
    dscr="a11 a12 a13\na21 a22 a23\na31 a32 a33",
    },{
    text({"\\begin{array}{ccc}",""}),
    insert(1, "a_{11}"),
    text({" & "}),
    insert(2, "a_{12}"),
    text({" & "}),
    insert(3, "a_{13}"),
    text({" \\\\",""}),
    insert(4, "a_{21}"),
    text({" & "}),
    insert(5, "a_{22}"),
    text({" & "}),
    insert(6, "a_{23}"),
    text({" \\\\",""}),
    insert(7, "a_{31}"),
    text({" & "}),
    insert(8, "a_{32}"),
    text({" & "}),
    insert(9, "a_{33}"),
    text({" \\\\",""}),
    text({"\\end{array}"}),
  }),
  snip({
    trig="matrix4x4",
    name="matrix 4x4",
    dscr="a11 a12 a13 a14\na21 a22 a23 a24\na31 a32 a33 a34\na41 a42 a43 a44",
    },{
    text({"\\begin{array}{cccc}",""}),
    insert(1, "a_{11}"),
    text({" & "}),
    insert(2, "a_{12}"),
    text({" & "}),
    insert(3, "a_{13}"),
    text({" & "}),
    insert(4, "a_{14}"),
    text({" \\\\",""}),
    insert(5, "a_{21}"),
    text({" & "}),
    insert(6, "a_{22}"),
    text({" & "}),
    insert(7, "a_{23}"),
    text({" & "}),
    insert(8, "a_{24}"),
    text({" \\\\",""}),
    insert(9, "a_{31}"),
    text({" & "}),
    insert(10, "a_{32}"),
    text({" & "}),
    insert(11, "a_{33}"),
    text({" & "}),
    insert(12, "a_{34}"),
    text({" \\\\",""}),
    insert(13, "a_{41}"),
    text({" & "}),
    insert(14, "a_{42}"),
    text({" & "}),
    insert(15, "a_{43}"),
    text({" & "}),
    insert(16, "a_{44}"),
    text({" \\\\",""}),
    text({"\\end{array}"}),
  }),
  -- Vectors
  snip({
    trig="vector2",
    name="vector 2",
    dscr="a1\na2",
    },{
    text({"\\begin{array}{c}",""}),
    insert(1, "a_1"),
    text({" \\\\",""}),
    insert(2, "a_2"),
    text({" \\\\",""}),
    text({"\\end{array}"}),
  }),
  snip({
    trig="vector3",
    name="vector 3",
    dscr="a1\na2\na3",
    },{
    text({"\\begin{array}{c}",""}),
    insert(1, "a_1"),
    text({" \\\\",""}),
    insert(2, "a_2"),
    text({" \\\\",""}),
    insert(3, "a_3"),
    text({" \\\\",""}),
    text({"\\end{array}"}),
  }),
  snip({
    trig="vector4",
    name="vector 4",
    dscr="a1\na2\na3\na4",
    },{
    text({"\\begin{array}{c}",""}),
    insert(1, "a_1"),
    text({" \\\\",""}),
    insert(2, "a_2"),
    text({" \\\\",""}),
    insert(3, "a_3"),
    text({" \\\\",""}),
    insert(4, "a_4"),
    text({" \\\\",""}),
    text({"\\end{array}"}),
  })
})

-- latex
-- ls.add_snippets("latex",{
--   -- amsthm support
--   snip({
--     trig="def",
--     name="Definition",
--     dscr="amsthm definition block",
--     },{
--     text({"\\begin{definition}",""}),
--     insert(0),
--     text({"","\\end{definition}"}),
--   })
-- })
EOF

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
      -- { name = 'vsnip' }, -- For vsnip users
      { name = 'luasnip' }, -- For luasnip users
      { name = 'buffer' },
      { name = 'path' },
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
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'texlab',
  'tsserver',
  'hls',
  'rnix',
  'pyright',
  'clojure_lsp',
  'rls',
  'clangd',
  'ltex'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = {
      debounce_text_changes = 150,
    }
  }
end
nvim_lsp['java_language_server'].setup {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 150,
  },
  cmd = {"java-language-server"},
}
EOF

" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = function(lang, bufnr) -- Disable in python because this is currently broken TODO fix this
      return lang == "python" or lang == "vim"
    end,
  },
  rainbow = { -- nvim-ts-rainbow
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}
EOF

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

" vim2hs
  "let g:haskell_conceal_wide = 1
  let g:haskell_indent_disable=1
  let g:haskell_classic_highlighting=1

" delimitMate
  let delimitMate_expand_space=1
  let delimitMate_expand_cr=1

" vim-skeleton
  " TODO: This should be baked into the nix derivation
  " let g:skeleton_template_dir = "/etc/nixos/nvim/skeleton/"
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

" restore folds when reopening files
  " augroup remember_folds
  "   autocmd!
  "   autocmd BufWinLeave * mkview
  "   autocmd BufWinEnter * silent! loadview
  " augroup END

" enable spellchecker with F1
  map <F1> :set spell!<CR>

  " build nix projects with <F9>
    map <F9> :!nix-build<space>--quiet<enter>
    map <S-F9> :!nix-build<enter>

" prettyfy file
  nnoremap <F3> mzgggqG`z

" Sage
  autocmd FileType sage set syntax=python

" GO
  autocmd FileType go noremap <F5> <ESC>:GoRun

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
  autocmd FileType tex map <F5> :!pdflatex<space>%<enter>

" RMARKDOWN
  " If it is a bookdown book
  if filereadable("_build.sh")
    autocmd FileType rmarkdown map <F5> :!./_build.sh<enter>
  " Otherwise
  else
    autocmd FileType rmarkdown map <F5> :!Rscript<space>-e<space>'library(rmarkdown);render("%")'<enter>
  endif
  autocmd FileType rmadkdown setlocal expandtab
" MARKDOWN
  autocmd FileType markdown setlocal expandtab
  autocmd FileType markdown map <F5> :!pandoc<space>%<space>-o<space>%:r.pdf<enter>

" " CLOJURE
"   autocmd FileType clojure :Lein
