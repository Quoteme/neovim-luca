-- vim: tabstop=2 shiftwidth=2 expandtab
-- Load VSCode like snippets from external plugins
require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.env.VIMRUNTIME .. "/snippets/" } })

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

-- Repeat Insernode text
-- @param insert_node_id The id of the insert node to repeat (the first line from)
-- https://www.reddit.com/r/neovim/comments/s0llvm/luasnip_examples/
local ri = function (insert_node_id)
  return func(function (args) return args[1][1] end, insert_node_id)
end

-- Markdown
ls.filetype_extend("markdown",{"latex", "plaintext"})
ls.filetype_extend("latex",{"markdown", "plaintext"})
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
    text({"$$"}),
    insert(1),
    text({"$$"}),
  }),
  snip({
    trig="aligned",
    name="aligned math environment",
    dscr="\\begin{aligned} ... \\end{aligned}",
    },{
    text({"\\begin{aligned}",""}),
    insert(1),
    text({" &= "}),
    insert(2),
    text({" \\\\",""}),
    insert(3),
    text({" &= "}),
    insert(4),
    text({"","\\end{aligned}"}),
  }),
  snip({
    trig="equation",
    name="equation math environment with numbering",
    dscr="\\begin{equation} ... \\end{equation}",
    },{
    text({"\\begin{equation}",""}),
    insert(1),
    text({" &= "}),
    insert(2),
    text({" \\\\",""}),
    insert(3),
    text({" &= "}),
    insert(4),
    text({"","\\end{equation}"}),
  }),
  snip({
    trig="equation*",
    name="equation math environment without numbering",
    dscr="\\begin{equation*} ... \\end{equation*}",
    },{
    text({"\\begin{equation*}",""}),
    insert(1),
    text({" &= "}),
    insert(2),
    text({" \\\\",""}),
    insert(3),
    text({" &= "}),
    insert(4),
    text({"","\\end{equation*}"}),
  }),
  snip({
    trig="set",
    name="set",
    dscr="\\{ ... \\}",
    },{
    text({"\\{ "}),
    insert(1),
    text({" \\}"}),
  }),
  snip({
    trig="setcond",
    name="set with condition",
    dscr="\\{ ... | ... \\}",
    },{
    text({"\\{ "}),
    insert(1),
    text({" | "}),
    insert(2),
    text({" \\}"}),
  }),
  snip({
    trig="setdots",
    name="set with comma-seperated values",
    dscr="\\{ a, b, ... \\}",
    },{
    text({"\\{ "}),
    insert(1),
    text({", "}),
    insert(2),
    text({", \\dots \\}"}),
  }),
  snip({
    trig="setdotsfinite",
    name="set with comma-seperated values",
    dscr="\\{ a, b, ..., c \\}",
    },{
    text({"\\{ "}),
    insert(1),
    text({", "}),
    insert(2),
    text({", \\dots, "}),
    insert(3),
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
    trig="rr",
    name="real numbers",
    dscr="\\mathbb{R}",
    },{
    text({"\\mathbb{R}"}),
  }),
  snip({
    trig="cc",
    name="complex numbers",
    dscr="\\mathbb{C}",
    },{
    text({"\\mathbb{C}"}),
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
    trig="left(",
    name="\\left( ... \\right)",
    dscr="\\left( ... \\right)",
    },{
    text({"\\left("}),
    insert(1),
    text({"\\right)"}),
  }),
  snip({
    trig="left[",
    name="\\left[ ... \\right]",
    dscr="\\left[ ... \\right]",
    },{
    text({"\\left["}),
    insert(1),
    text({"\\right]"}),
  }),
  snip({
    trig="left\\{",
    name="\\left\\{ ... \\right\\}",
    dscr="\\left\\{ ... \\right\\}",
    },{
    text({"\\left\\{"}),
    insert(1),
    text({"\\right\\}"}),
  }),
  -- Quantum Conputation
  snip({
    trig="overline",
    name="overline",
    dscr="–\nx",
    },{
    text({"\\overline{ "}),
    insert(1),
    text({" }"}),
  }),
  snip({
    trig="spec",
    name="Spectrum of a Matrix/Ring",
    dscr="Spectrum of a Matrix: Set of all eigenvektors\nSpectrum of a Ring: Set of all prime ideals",
    },{
    text({"\\text{Spec}( "}),
    insert(1),
    text({" )"}),
  }),
  snip({
    trig="sum",
    name="sum",
    dscr=" n \n___\n\\ \n/    a\n¯¯¯   n\nj=1",
    },{
    text({"\\sum_{"}),
    insert(1),
    text({" = "}),
    insert(2),
    text({"}^{"}),
    insert(3),
    text({"}"}),
  }),
  snip({
    trig="prod",
    name="prod",
    dscr="  n  \n_____\n | | \n | |  a\n | |   5\n j=1",
    },{
    text({"\\sum_{"}),
    insert(1),
    text({" = "}),
    insert(2),
    text({"}^{"}),
    insert(3),
    text({"}"}),
  }),
  snip({
    trig="bra",
    name="bra from \\usepackage{braket}",
    dscr="< ... |",
    },{
    text({"\\Bra{ "}),
    insert(1),
    text({" }"}),
  }),
  snip({
    trig="ket",
    name="ket from \\usepackage{braket}",
    dscr="| ... >",
    },{
    text({"\\Ket{ "}),
    insert(1),
    text({" }"}),
  }),
  snip({
    trig="braket",
    name="braket from \\usepackage{braket}",
    dscr="< ... | ... >",
    },{
    text({"\\Braket{ "}),
    insert(1),
    text({" | "}),
    insert(2),
    text({" }"}),
  }),
  -- snip({
  --   trig="bra",
  --   name="< ... |",
  --   dscr="\\langle ... |",
  --   },{
  --   text({"\\langle "}),
  --   insert(1),
  --   text({" |"}),
  -- }),
  -- snip({
  --   trig="ket",
  --   name="| ... >",
  --   dscr="| ... \\rangle",
  --   },{
  --   text({"| "}),
  --   insert(1),
  --   text({" \\rangle"}),
  -- }),
  -- snip({
  --   trig="braket",
  --   name="< ... | ... >",
  --   dscr="\\langle ... | ... \\rangle",
  --   },{
  --   text({"\\langle "}),
  --   insert(1),
  --   text({" | "}),
  --   insert(2),
  --   text({" \\rangle"}),
  -- }),
  -- amsthm support
  snip({
    trig="def",
    name="Definition",
    dscr="amsthm definition block",
    },{
    text({"\\begin{definition}["}),
    insert(1,"name"),
    text({"]","    "}),
    insert(2),
    text({"","\\end{definition}"}),
  }),
  snip({
    trig="thm",
    name="Theorem",
    dscr="amsthm theorem block",
    },{
    text({"\\begin{theorem}["}),
    insert(1,"name"),
    text({"]","    "}),
    insert(2),
    text({"","\\end{theorem}"}),
  }),
  snip({
    trig="prop",
    name="Proposition",
    dscr="amsthm proposition block",
    },{
    text({"\\begin{proposition}["}),
    insert(1,"name"),
    text({"]","    "}),
    insert(2),
    text({"","\\end{proposition}"}),
  }),
  snip({
    trig="lem",
    name="Lemmata",
    dscr="amsthm lemmata block",
    },{
    text({"\\begin{lemmata}["}),
    insert(1,"name"),
    text({"]","    "}),
    insert(2),
    text({"","\\end{lemmata}"}),
  }),
  snip({
    trig="cor",
    name="Corollary",
    dscr="amsthm corollary block",
    },{
    text({"\\begin{corollary}["}),
    insert(1,"name"),
    text({"]","    "}),
    insert(2),
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
    text({"\\begin{bmatrix} "}),
    insert(1, "a_{11}"),
    text({" & "}),
    insert(2, "a_{12}"),
    text({" \\\\ "}),
    insert(3, "a_{21}"),
    text({" & "}),
    insert(4, "a_{22}"),
    text({" \\\\"}),
    text({" \\end{bmatrix}"}),
  }),
  snip({
    trig="matrix3x3",
    name="matrix 3x3",
    dscr="a11 a12 a13\na21 a22 a23\na31 a32 a33",
    },{
    text({"\\begin{bmatrix}",""}),
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
    text({"\\end{bmatrix}"}),
  }),
  snip({
    trig="matrix4x4",
    name="matrix 4x4",
    dscr="a11 a12 a13 a14\na21 a22 a23 a24\na31 a32 a33 a34\na41 a42 a43 a44",
    },{
    text({"\\begin{bmatrix}",""}),
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
    text({"\\end{bmatrix}"}),
  }),
  -- Vectors
  snip({
    trig="vector2",
    name="vector 2",
    dscr="a1\na2",
    },{
    text({"\\begin{bmatrix}",""}),
    insert(1, "a_1"),
    text({" \\\\",""}),
    insert(2, "a_2"),
    text({" \\\\",""}),
    text({"\\end{bmatrix}"}),
  }),
  snip({
    trig="vector3",
    name="vector 3",
    dscr="a1\na2\na3",
    },{
    text({"\\begin{bmatrix}",""}),
    insert(1, "a_1"),
    text({" \\\\",""}),
    insert(2, "a_2"),
    text({" \\\\",""}),
    insert(3, "a_3"),
    text({" \\\\",""}),
    text({"\\end{bmatrix}"}),
  }),
  snip({
    trig="vector4",
    name="vector 4",
    dscr="a1\na2\na3\na4",
    },{
    text({"\\begin{bmatrix}",""}),
    insert(1, "a_1"),
    text({" \\\\",""}),
    insert(2, "a_2"),
    text({" \\\\",""}),
    insert(3, "a_3"),
    text({" \\\\",""}),
    insert(4, "a_4"),
    text({" \\\\",""}),
    text({"\\end{bmatrix}"}),
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

-- nix
ls.add_snippets("nix",{
  snip({
    trig="flake",
    name="Default flake template",
    dscr="simle nix-flake template",
    },{
    text({"{",""}),
    text({"  description = \""}),insert(1, "a simple project"),text({"\";", ""}),
    text({"",""}),
    text({"  inputs = {",""}),
    text({"    nixpkgs.url = \"github:nixos/nixpkgs/nixpkgs-unstable\";",""}),
    text({"    flake-utils = {",""}),
    text({"      inputs.nixpkgs.follows = \"nixpkgs\";",""}),
    text({"      url = \"github:numtide/flake-utils\";",""}),
    text({"    };",""}),
    text({"  };",""}),
    text({"",""}),
    text({"  outputs = { self, nixpkgs, flake-utils, ... }@inputs:",""}),
    text({"    flake-utils.lib.eachDefaultSystem (system:",""}),
    text({"      let",""}),
    text({"        pkgs = import nixpkgs { inherit system; };",""}),
    text({"      in",""}),
    text({"        rec {",""}),
    text({"          defaultApp = apps."}),insert(2, "app_name"),text({";",""}),
    text({"          defaultPackage = packages."}),insert(3, "package_name"),text({";",""}),
    text({"",""}),
    text({"          apps."}),ri(2),text({" = {",""}),
    text({"            type = \"app\";",""}),
    text({"            program = \"${defaultPackage}/bin/"}),insert(4, "default_binary"),text({"\";",""}),
    text({"          };"}),
    text({"",""}),
    text({"          packages."}),ri(3),text({" = "}),insert(5, "derivation"),text({"",""}),
    text({"        }",""}),
    text({"      );",""}),
    text({"}"}),
  }),
  snip({
    trig="derivation",
    name="stdenv.mkDerivation",
    dscr="Simple derivation",
    },{
    text({"stdenv.mkDerivation {", ""}),
    text({"  name = \""}),insert(1, "name"),text({"\";",""}),
    text({"  pname = \""}),ri(1),text({"\";",""}),
    text({"  version = \""}),insert(2, "1.0"),text({"\";",""}),
    text({"  src = "}),insert(3, "./src"),text({";",""}),
    text({"",""}),
    text({"  buildInputs = with pkgs; [",""}),
    text({"    "}),insert(4, "dependency"),text({"",""}),
    text({"  ];",""}),
    text({"  buildPhase = ''",""}),
    text({"    "}),insert(5, "cp $src/bin/lal $out/bin/lal"),text({"",""}),
    text({"  '';",""}),
    text({"  installPhase = ''",""}),
    text({"    "}),insert(5, "cp $src/bin/lal $out/bin/lal"),text({"",""}),
    text({"  '';",""}),
    text({"};"}),
  }),
  snip({
    trig="symlinkJoin",
    name="pkgs.symlinkJoin",
    dscr="join multiple derivations using symlinks",
    },{
    text({"pkgs.symlinkJoin {",""}),
    text({"  name = \""}),insert(1,"name"),text({"\";",""}),
    text({"  paths = [",""}),
    text({"    "}),insert(2,"derivation"),text({"",""}),
    text({"  ];",""}),
    text({"",""}),
    text({"  nativeBuildInputs = [ pkgs.makeWrapper ];",""}),
    text({"  postBuild = ''",""}),
    text({"    wrapProgram $out/bin/"}),insert(3,"binary"),text({" \\",""}),
    text({"    --prefix PATH : $out/bin",""}),
    text({"  '';",""}),
    text({"};"}),
  })
})
