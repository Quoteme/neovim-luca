{
  description = "Luca's simple Neovim flake for easy configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
    flake-utils = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/flake-utils";
    };

    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ltex-ls = {
      url = "https://github.com/valentjn/ltex-ls/releases/download/15.2.0/ltex-ls-15.2.0-linux-x64.tar.gz";
      flake = false;
    };

    # Theme / Colorscheme
    "plugin__onedark-vim" = { url = "github:joshdick/onedark.vim"; flake = false; };
    "plugin__catppuccin" = { url = "github:catppuccin/nvim"; flake = false; };

    # Color
    "plugin__nvim-colorizer.lua" = { url = "github:norcalli/nvim-colorizer.lua"; flake = false; };
    "plugin__twilight_nvim" = { url = "github:folke/twilight.nvim"; flake = false; };

    # Programming Language Specific stuff

    ## Dart / Flutter
    "plugin__dart-vim-plugin" = { url = "github:dart-lang/dart-vim-plugin"; flake = false; };
    "plugin__flutter-tools.nvim" = { url = "github:akinsho/flutter-tools.nvim"; flake = false; };

    ## Yuck (for eww)
    "plugin__yuck.vim" = { url = "github:elkowar/yuck.vim"; flake = false; };

    ## SAGE
    "plugin__vim-sage" = { url = "github:petRUShka/vim-sage"; flake = false; };

    ## NIX
    "plugin__vim-nix" = { url = "github:LnL7/vim-nix"; flake = false; };

    ## Clojure
    "plugin__vim-dispatch" = { url = "github:tpope/vim-dispatch"; flake = false; };
    "plugin__vim-dispatch-neovim" = { url = "github:radenling/vim-dispatch-neovim"; flake = false; };
    "plugin__vim-jack-in" = { url = "github:clojure-vim/vim-jack-in"; flake = false; };
    "plugin__conjure" = { url = "github:Olical/conjure"; flake = false; };
    "plugin__vim-repeat" = { url = "github:tpope/vim-repeat"; flake = false; };
    "plugin__vim-surround" = { url = "github:tpope/vim-surround"; flake = false; };
    "plugin__vim-sexp" = { url = "github:guns/vim-sexp"; flake = false; };
    "plugin__vim-sexp-mappings-for-regular-people" = { url = "github:tpope/vim-sexp-mappings-for-regular-people"; flake = false; };

    ## F#
    "plugin__neofsharp_vim" = { url = "github:adelarsq/neofsharp.vim"; flake = false; };

    # Debugging
    "plugin__nvim-dap" = { url = "github:mfussenegger/nvim-dap"; flake = false; };
    "plugin__nvim-dap-ui" = { url = "github:rcarriga/nvim-dap-ui"; flake = false; };
    "plugin__vimspector" = { url = "github:puremourning/vimspector"; flake = false; };

    ## Debugging - Adapters
    "plugin__nvim-dap-python" = { url = "github:mfussenegger/nvim-dap-python"; flake = false; };

    # Tree-sitter
    "plugin__nvim-treesitter" = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    "plugin__nvim-ts-rainbow" = { url = "github:p00f/nvim-ts-rainbow"; flake = false; };

    # Language Server Protocol
    "plugin__trouble_nvim" = { url = "github:folke/trouble.nvim"; flake = false; };
    "plugin__nvim-lspconfig" = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    "plugin__lsp_signature_nvim" = { url = "github:ray-x/lsp_signature.nvim"; flake = false; };

    ## code actions
    "plugin__nvim-code-action-menu" = { url = "github:weilbith/nvim-code-action-menu"; flake = false; };
    "plugin__nvim-lightbulb" = { url = "github:kosayoda/nvim-lightbulb"; flake = false; };

    ## Completion Engine
    "plugin__nvim-cmp" = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    "plugin__cmp-nvim-lua" = { url = "github:hrsh7th/cmp-nvim-lua"; flake = false; };
    "plugin__cmp-nvim-lsp" = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    "plugin__lspkind_nvim" = { url = "github:onsails/lspkind.nvim"; flake = false; };
    "plugin__cmp-buffer" = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
    "plugin__cmp-nvim-lsp-document-symbol" = { url = "github:hrsh7th/cmp-nvim-lsp-document-symbol"; flake = false; };
    "plugin__cmp-path" = { url = "github:hrsh7th/cmp-path"; flake = false; };
    "plugin__cmp-spell" = { url = "github:f3fora/cmp-spell"; flake = false; };
    "plugin__cmp-dictionary" = { url = "github:uga-rosa/cmp-dictionary"; flake = false; };
    "plugin__cmp-cmdline" = { url = "github:hrsh7th/cmp-cmdline"; flake = false; };
    "plugin__cmp-cmdline-history" = { url = "github:dmitmel/cmp-cmdline-history"; flake = false; };
    "plugin__cmp-rg" = { url = "github:lukas-reineke/cmp-rg"; flake = false; };
    "plugin__cmp-greek" = { url = "github:max397574/cmp-greek"; flake = false; };
    "plugin__cmp-latex-symbols" = { url = "github:kdheepak/cmp-latex-symbols"; flake = false; };
    "plugin__cmp-emoji" = { url = "github:hrsh7th/cmp-emoji"; flake = false; };
    "plugin__cmp-pandoc_nvim" = { url = "github:aspeddro/cmp-pandoc.nvim"; flake = false; };

    ## Snippets
    "plugin__LuaSnip" = { url = "github:L3MON4D3/LuaSnip"; flake = false; };
    "plugin__cmp_luasnip" = { url = "github:saadparwaiz1/cmp_luasnip"; flake = false; };
    "plugin__snippets-java" = { url = "github:tushortz/vscode-Java-Snippets"; flake = false; };
    "plugin__snippets-shebang" = { url = "github:Rpinski/vscode-shebang-snippets"; flake = false; };
    "plugin__friendly-snippets" = { url = "github:rafamadriz/friendly-snippets"; flake = false; };
    "plugin__vim-snippets" = { url = "github:honza/vim-snippets"; flake = false; };
    "plugin__dartlang-snippets" = { url = "github:natebosch/dartlang-snippets"; flake = false; };

    ## Github Copilot
    "plugin__copilot.vim" = { url = "github:github/copilot.vim"; flake = false; };
    "plugin__copilot.lua" = { url = "github:zbirenbaum/copilot.lua"; flake = false; };
    "plugin__copilot-cmp" = { url = "github:zbirenbaum/copilot-cmp"; flake = false; };

    # Note taking
    "plugin__nabla_nvim" = { url = "github:jbyuki/nabla.nvim"; flake = false; };
    "plugin__pandoc_nvim" = { url = "github:aspeddro/pandoc.nvim"; flake = false; };
    "plugin__clipboard-image_nvim" = { url = "github:ekickx/clipboard-image.nvim"; flake = false; };
    "plugin__nvimager" = { url = "github:mbpowers/nvimager"; flake = false; };

    # Documentation
    "plugin__neogen" = { url = "github:danymat/neogen"; flake = false; };

    # File browsing
    "plugin__neo-tree" = { url = "github:nvim-neo-tree/neo-tree.nvim"; flake = false; };
    "plugin__nui_nvim" = { url = "github:MunifTanjim/nui.nvim"; flake = false; };

    # Sessions
    "plugin__auto-session" = { url = "github:rmagatti/auto-session"; flake = false; };

    # Code browsing
    "plugin__symbols-outline_nvim" = { url = "github:simrat39/symbols-outline.nvim"; flake = false; };
    "plugin__todo-comments_nvim" = { url = "github:folke/todo-comments.nvim"; flake = false; };
    "plugin__codewindow_nvim" = { url = "github:gorbit99/codewindow.nvim"; flake = false; };
    "plugin__nvim-navic" = { url = "github:smiteshp/nvim-navic"; flake = false; };
    "plugin__barbecue_nvim" = { url = "github:utilyre/barbecue.nvim"; flake = false; };

    # Code testing
    "plugin__neotest" = { url = "github:nvim-neotest/neotest"; flake = false; };
    "plugin__neotest-vim-test" = { url = "github:nvim-neotest/neotest-vim-test"; flake = false; };
    "plugin__vim-test" = { url = "github:vim-test/vim-test"; flake = false; };
    "plugin__nvim-coverage" = { url = "github:andythigpen/nvim-coverage"; flake = false; };

    ## Code testing - Language specific
    "plugin__neotest-python" = { url = "github:nvim-neotest/neotest-python"; flake = false; };
    "plugin__neotest-dart" = { url = "github:sidlatau/neotest-dart"; flake = false; };
    "plugin__neotest-haskell" = { url = "github:mrcjkb/neotest-haskell"; flake = false; };
    "plugin__neotest-deno" = { url = "github:MarkEmmons/neotest-deno"; flake = false; };
    "plugin__neotest-plenary" = { url = "github:nvim-neotest/neotest-plenary"; flake = false; };

    # Git integration
    "plugin__gitsigns_nvim" = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };

    # Utilities
    "plugin__tabular" = { url = "github:godlygeek/tabular"; flake = false; };
    "plugin__vim-matchup" = { url = "github:andymass/vim-matchup"; flake = false; };
    "plugin__delimitMate" = { url = "github:Raimondi/delimitMate"; flake = false; };
    "plugin__vim-commentary" = { url = "github:tpope/vim-commentary"; flake = false; };
    "plugin__vim-visual-multi" = { url = "github:mg979/vim-visual-multi"; flake = false; };
    "plugin__vim-skeleton" = { url = "github:noahfrederick/vim-skeleton"; flake = false; };
    "plugin__indent-blankline_nvim" = { url = "github:lukas-reineke/indent-blankline.nvim"; flake = false; };
    "plugin__neoscroll_nvim" = { url = "github:karb94/neoscroll.nvim"; flake = false; };

    ## Package manager
    "plugin__mason_nvim" = { url = "github:williamboman/mason.nvim"; flake = false; };
    "plugin__mason-lspconfig_nvim" = { url = "github:williamboman/mason-lspconfig.nvim"; flake = false; };

    ## folding
    "plugin__fold-cycle_nvim" = { url = "github:jghauser/fold-cycle.nvim"; flake = false; };
    "plugin__pretty-fold_nvim" = { url = "github:anuvyklack/pretty-fold.nvim"; flake = false; };

    ### fold-preview
    "plugin__fold-preview_nvim" = { url = "github:anuvyklack/fold-preview.nvim"; flake = false; };
    "plugin__nvim-keymap-amend" = { url = "github:anuvyklack/nvim-keymap-amend"; flake = false; };

    ## Splits and windows
    "plugin__focus_nvim" = { url = "github:beauwilliams/focus.nvim"; flake = false; };

    ## Cheatcheet
    "plugin__plenary_nvim" = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    "plugin__telescope_nvim" = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    "plugin__popup_nvim" = { url = "github:nvim-lua/popup.nvim"; flake = false; };
    "plugin__cheatsheet_nvim" = { url = "github:sudormrfbin/cheatsheet.nvim"; flake = false; };
    "plugin__legendary_nvim" = { url = "github:mrjones2014/legendary.nvim"; flake = false; };
    "plugin__which-key_nvim" = { url = "github:folke/which-key.nvim"; flake = false; };

    ## Better Graphics
    "plugin__dressing_nvim" = { url = "github:stevearc/dressing.nvim"; flake = false; };

    ### Notification
    "plugin__nvim-notify" = { url = "github:rcarriga/nvim-notify"; flake = false; };

    ## Buffer line / tabline  / statusline
    "plugin__nvim-web-devicons" = { url = "github:kyazdani42/nvim-web-devicons"; flake = false; };
    "plugin__barbar_nvim" = { url = "github:romgrk/barbar.nvim"; flake = false; };
    "plugin__lualine_nvim" = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };

    ## marks
    "plugin__marks_nvim" = { url = "github:chentoast/marks.nvim"; flake = false; };

    ## Gestures
    "plugin__gesture_nvim" = { url = "github:notomo/gesture.nvim"; flake = false; };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    # This line makes this package availeable for all systems
    # ("x86_64-linux", "aarch64-linux", "i686-linux", "x86_64-darwin",...)
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Extra programs
        extraPrograms = with pkgs; [
          # Language servers
          ## Bash
          nodePackages.bash-language-server
          ## LaTex
          texlab
          ## Haskell
          pkgs.stable.haskell-language-server
          ormolu
          ## JavaScript / Typescript / HTML / CSS
          # nodePackages.vscode-langservers-extracted
          # deno
          ## NIX
          rnix-lsp
          ## Python
          # python39Packages.jedi-language-server
          # nodePackages.pyright
          ## Rust
          # rust-analyzer
          ## Clojure
          # clojure-lsp
          ## C
          clang-tools
          ## Cmake
          # cmake-language-server
          ## Java
          jdk11
          # java-language-server
          ## Lua
          sumneko-lua-language-server
          ## Dart
          # dart
          ## (Neo)Vim
          nodePackages.vim-language-server
          ## Docker
          # nodePackages.dockerfile-language-server-nodejs
          ## FSharp
          dotnet-sdk
          # Other dependencies
          xcolor
          xclip
          ueberzug
          # Spelling and grammar
          languagetool
        ];
        # Once we add this overlay to our nixpkgs, we are able to
        # use `pkgs.neovimPlugins`, which is a map of our plugins.
        # Each input in the format:
        # ```
        # "plugin__yourPluginName" = {
        #   url   = "github:exampleAuthor/examplePlugin";
        #   flake = false;
        # };
        # ```
        # included in the `inputs` section is packaged to a (neo-)vim
        # plugin and can then be used via
        # ```
        # pkgs.neovimPlugins.yourPluginName
        # ```
        pluginOverlay = final: prev:
          let
            inherit (prev.vimUtils) buildVimPluginFrom2Nix;
            # treesitterGrammars = prev.tree-sitter.withPlugins (_: prev.tree-sitter.allGrammars);
            plugins = builtins.filter
              (s: (builtins.match "plugin__.*" s) != null)
              (builtins.attrNames inputs);
            plugName = input:
              builtins.substring
                (builtins.stringLength "plugin__")
                (builtins.stringLength input)
                input;
            buildPlug = name: buildVimPluginFrom2Nix {
              pname = plugName name;
              version = "master";
              src = builtins.getAttr name inputs;

              # Tree-sitter fails for a variety of lang grammars unless using :TSUpdate
              # For now install imperatively
              #postPatch =
              #  if (name == "nvim-treesitter") then ''
              #    rm -r parser
              #    ln -s ${treesitterGrammars} parser
              #  '' else "";
            };
          in
          {
            neovimPlugins = builtins.listToAttrs (map
              (plugin: {
                name = plugName plugin;
                value = buildPlug plugin;
              })
              plugins);
          };

        # Apply the overlay and load nixpkgs as `pkgs`
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            pluginOverlay
            (final: prev: {
              neovim-unwrapped = inputs.neovim-flake.packages.${prev.system}.neovim;
            })
            (final: prev: {
              stable = import inputs.nixpkgs-stable { inherit system; config.allowUnfree = true; };
            })
          ];
        };

        # neovimBuilder is a function that takes your prefered
        # configuration as input and just returns a version of
        # neovim where the default config was overwritten with your
        # config.
        # 
        # Parameters:
        # customRC | your init.vim as string
        # viAlias  | allow calling neovim using `vi`
        # vimAlias | allow calling neovim using `vim`
        # start    | The set of plugins to load on every startup
        #          | The list is in the form ["yourPluginName" "anotherPluginYouLike"];
        #          |
        #          | Important: The default is to load all plugins, if
        #          |            `start = [ "blabla" "blablabla" ]` is
        #          |            not passed as an argument to neovimBuilder!
        #          |
        #          | Make sure to add:
        #          | ```
        #          | "plugin__yourPluginName" = {
        #          |   url   = "github:exampleAuthor/examplePlugin";
        #          |   flake = false;
        #          | };
        #          | 
        #          | "plugin__anotherPluginYouLike" = {
        #          |   url   = "github:exampleAuthor/examplePlugin";
        #          |   flake = false;
        #          | };
        #          | ```
        #          | to your imports!
        # opt      | List of optional plugins to load only when 
        #          | explicitly loaded from inside neovim
        neovimBuilder =
          { customRC ? ""
          , viAlias ? false
          , vimAlias ? false
          , start ? builtins.attrValues pkgs.neovimPlugins
          , opt ? [ ]
          , debug ? false
          , dependencies ? [ ]
          }:
          let
            myNeovimUnwrapped = pkgs.neovim-unwrapped.overrideAttrs (prev: {
              propagatedBuildInputs = with pkgs; [
                # TODO find out why this is here
                pkgs.stdenv.cc.cc.lib
              ];
            });
            neovim-wrapped = pkgs.wrapNeovim myNeovimUnwrapped {
              inherit viAlias;
              inherit vimAlias;
              configure = {
                customRC = customRC;
                packages.myVimPackage = with pkgs.neovimPlugins; {
                  start = start;
                  opt = opt;
                };
              };
            };
            neovim-withExternalDependencies = pkgs.symlinkJoin {
              # here we add some external programs to neovim
              # which means that neovim will be installed
              # in a way that also installs these programs.
              # This also means, that neovim can call them
              # even if the user has not installed them
              # system-wide
              name = "neovim";
              paths = with pkgs; [ neovim-wrapped ]
                ++ dependencies
                ++ extraPrograms;
              src = ./.;
              nativeBuildInputs = [
                pkgs.makeWrapper
                (pkgs.aspellWithDicts (dicts: with dicts; [ en de ]))
              ];
              postBuild = ''
                # Add ltex-ls
                ln -sf ${inputs.ltex-ls}/bin/ltex-ls $out/bin/ltex-ls
                wrapProgram $out/bin/ltex-ls \
                  --set JAVA_HOME ${pkgs.jdk11}

                # add external dependencies to path of neovim
                wrapProgram $out/bin/nvim \
                  --suffix PATH : $out/bin \
                  --suffix PATH : ${pkgs.lib.makeBinPath extraPrograms} \
                  --prefix RUNTIME_EXTRA : $out/share/nvim/runtime_extra

                # Create runtime_extra
                mkdir -p $out/share/nvim/runtime_extra
                cp -r $src/runtime_extra/* $out/share/nvim/runtime_extra/
                # Create dictionaries for cmp-dictionary
                mkdir -p $out/share/nvim/runtime_extra/dictionaries/
                aspell -d de dump master | aspell -l de expand > $out/share/nvim/runtime_extra/dictionaries/de.dict
                aspell -d en dump master | aspell -l en expand > $out/share/nvim/runtime_extra/dictionaries/en.dict
                # Make aliases for neovim command
                ln -sf $out/bin/nvim $out/bin/vi
                ln -sf $out/bin/nvim $out/bin/vim
                ln -sf $out/bin/nvim $out/bin/neovim
                ln -sf $out/bin/nvim $out/bin/neovim-luca
              '';
            };
          in
          neovim-withExternalDependencies;
      in
      rec {
        defaultApp = packages.neovimLuca;
        defaultPackage = packages.neovimLuca;

        apps.nvim = {
          type = "app";
          program = "${defaultPackage}/bin/nvim";
        };

        packages.neovimLuca = neovimBuilder {
          # the next line loads a trivial example of a init.vim:
          customRC = pkgs.lib.readFile ./init.vim;
          # Add sniprun as an extra plugin from nixpkgs because idk
          # how to build it from source yet
          start = (builtins.attrValues pkgs.neovimPlugins)
            ++ [
            pkgs.vimPlugins.sniprun
            pkgs.vimPlugins.markdown-preview-nvim
          ];
          dependencies = with pkgs; [
            # Telescope
            fd
            ripgrep
            bat
            # Treesitter
            gcc
            toilet
            nodejs-16_x
            packages.ltex-ls
          ];
          # if you wish to only load the onedark-vim colorscheme:
          # start = with pkgs.neovimPlugins; [ onedark-vim ];
        };

        # This should somehow be integrated into neovimLuca but idk how
        apps.ltex-ls = {
          type = "app";
          program = "${packages.ltex-ls}/bin/ltex-ls";
        };

        packages.ltex-ls = pkgs.symlinkJoin {
          name = "ltex-ls";
          paths = [
            pkgs.jdk11
          ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            ln -sf ${inputs.ltex-ls}/bin/ltex-ls $out/bin/ltex-ls
            wrapProgram $out/bin/ltex-ls \
              --set JAVA_HOME ${pkgs.jdk11}
          '';
        };

      }
    );
}
