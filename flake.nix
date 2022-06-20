{
  description = "Luca's simple Neovim flake for easy configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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

    java-debug = {
      url = "github:microsoft/java-debug";
      flake = false;
    };
    
    # runtime stores all the settings which will be copied into the vim runtime
    runtime = {
      url = "path:./runtime/";
      flake = false;
    };

    # Theme
      "plugin:onedark-vim" = {
        url = "github:joshdick/onedark.vim";
        flake = false;
      };
    # Splits and windows
      "plugin:focus.nvim" = {
        url = "github:beauwilliams/focus.nvim";
        flake = false;
      };
    # Programming Language Specific stuff
      # SAGE
        "plugin:vim-sage" = {
          url = "github:petRUShka/vim-sage";
          flake = false;
        };
      # NIX
        "plugin:vim-nix" = {
          url = "github:LnL7/vim-nix";
          flake = false;
        };
      # Clojure
        "plugin:vim-dispatch" = {
          url = "github:tpope/vim-dispatch";
          flake = false;
        };
        "plugin:vim-dispatch-neovim" = {
          url = "github:radenling/vim-dispatch-neovim";
          flake = false;
        };
        "plugin:vim-jack-in" = {
          url = "github:clojure-vim/vim-jack-in";
          flake = false;
        };
        "plugin:conjure" = {
          url = "github:Olical/conjure";
          flake = false;
        };
        "plugin:vim-repeat" = {
          url = "github:tpope/vim-repeat";
          flake = false;
        };
        "plugin:vim-surround" = {
          url = "github:tpope/vim-surround";
          flake = false;
        };
        "plugin:vim-sexp" = {
          url = "github:guns/vim-sexp";
          flake = false;
        };
        "plugin:vim-sexp-mappings-for-regular-people" = {
          url = "github:tpope/vim-sexp-mappings-for-regular-people";
          flake = false;
        };
      # JAVA
        "plugin:nvim-jdtls" = {
          url = "github:mfussenegger/nvim-jdtls";
          flake = false;
        };
    # General help
      # Debugging
        # "plugin:nvim-dap" = {
        #   url = "github:mfussenegger/nvim-dap";
        #   flake = false;
        # };
        "plugin:vimspector" = {
          url = "github:puremourning/vimspector";
          flake = false;
        };
      # Tree-sitter
        "plugin:nvim-treesitter" = {
          url = "github:nvim-treesitter/nvim-treesitter";
          flake = false;
        };
        "plugin:nvim-ts-rainbow" = {
          url = "github:p00f/nvim-ts-rainbow";
          flake = false;
        };
      # Language Server Protocol
        "plugin:nvim-lspconfig" = {
          url = "github:neovim/nvim-lspconfig";
          flake = false;
        };
        "plugin:lsp_signature.nvim" = {
          url = "github:ray-x/lsp_signature.nvim";
          flake = false;
        };
        # code actions
        "plugin:nvim-code-action-menu" = {
          url = "github:weilbith/nvim-code-action-menu";
          flake = false;
        };
        "plugin:nvim-lightbulb" = {
          url = "github:kosayoda/nvim-lightbulb";
          flake = false;
        };
        # Completion Engine
          "plugin:nvim-cmp" = {
            url = "github:hrsh7th/nvim-cmp";
            flake = false;
          };
          "plugin:cmp-nvim-lsp" = {
            url = "github:hrsh7th/cmp-nvim-lsp";
            flake = false;
          };
          "plugin:cmp-buffer" = {
            url = "github:hrsh7th/cmp-buffer";
            flake = false;
          };
          "plugin:cmp-path" = {
            url = "github:hrsh7th/cmp-path";
            flake = false;
          };
          "plugin:cmp-spell" = {
            url = "github:f3fora/cmp-spell";
            flake = false;
          };
          "plugin:cmp-latex-symbols" = {
            url = "github:kdheepak/cmp-latex-symbols";
            flake = false;
          };
          "plugin:cmp-emoji" = {
            url = "github:hrsh7th/cmp-emoji";
            flake = false;
          };
          "plugin:cmp-pandoc.nvim" = {
            url = "github:aspeddro/cmp-pandoc.nvim";
            flake = false;
          };
          # Snippets
            "plugin:LuaSnip" = {
              url = "github:L3MON4D3/LuaSnip";
              flake = false;
            };
            "plugin:cmp_luasnip" = {
              url = "github:saadparwaiz1/cmp_luasnip";
              flake = false;
            };
            snippets-java = {
              url = "github:tushortz/vscode-Java-Snippets";
              flake = false;
            };
            snippets-shebang = {
              url = "github:Rpinski/vscode-shebang-snippets";
              flake = false;
            };
            # "plugin:vim-vsnip" = {
            #   url = "github:hrsh7th/vim-vsnip";
            #   flake = false;
            # };
            # TODO add custom snippts
            # "plugin:cmp-vsnip" = {
            #   url = "github:hrsh7th/cmp-vsnip";
            #   flake = false;
            # };
            # TODO add custom snippts
            "plugin:friendly-snippets" = {
              url = "github:rafamadriz/friendly-snippets";
              flake = false;
            };
            # TODO add custom snippts
            "plugin:vim-snippets" = {
              url = "github:honza/vim-snippets";
              flake = false;
            };
          # Github Copilot
            # This is only needed for authentication
            "plugin:copilot.vim" = {
              url = "github:github/copilot.vim";
              flake = false;
            };
            "plugin:copilot.lua" = {
              url = "github:zbirenbaum/copilot.lua";
              flake = false;
            };
            "plugin:copilot-cmp" = {
              url = "github:zbirenbaum/copilot-cmp";
              flake = false;
            };
        # Documentation
          "plugin:neogen" = {
            url = "github:danymat/neogen";
            flake = false;
          };
        # File browsing
          "plugin:neo-tree" = {
            url = "github:nvim-neo-tree/neo-tree.nvim";
            flake = false;
          };
          # Required by neo-tree
            "plugin:nui.nvim" = {
              url = "github:MunifTanjim/nui.nvim";
              flake = false;
            };
        # Code browsing
          # "plugin:aerial.nvim" = {
          #   url = "github:stevearc/aerial.nvim";
          #   flake = false;
          # };
          "plugin:symbols-outline.nvim" = {
            url = "github:simrat39/symbols-outline.nvim";
            flake = false;
          };
          "plugin:todo-comments.nvim" = {
            url = "github:folke/todo-comments.nvim";
            flake = false;
          };
        # Code testing
          "plugin:vim-test" = {
            url = "github:vim-test/vim-test";
            flake = false;
          };
      # Code execution
        # TODO sniprun is installed from nixpkgs. Add nixpkgs option
        # "plugin:sniprun" = {
        #   url = "github:michaelb/sniprun";
        #   flake = false;
        # };
        # Notification
          "plugin:nvim-notify" = {
            url = "github:rcarriga/nvim-notify";
            flake = false;
          };
        "plugin:vim-slime" = {
          url = "github:jpalardy/vim-slime";
          flake = false;
        };
      # Git integration
        "plugin:gitsigns.nvim" = {
          url = "github:lewis6991/gitsigns.nvim";
          flake = false;
        };
      # Color
        "plugin:nvim-colorizer.lua" = {
          url = "github:norcalli/nvim-colorizer.lua";
          flake = false;
        };
        "plugin:twilight.nvim" = {
          url = "github:folke/twilight.nvim";
          flake = false;
        };
      "plugin:tabular" = {
        url = "github:godlygeek/tabular";
        flake = false;
      };
      "plugin:vim-matchup" = {
        url = "github:andymass/vim-matchup";
        flake = false;
      };
      "plugin:delimitMate" = {
        url = "github:Raimondi/delimitMate";
        flake = false;
      };
      # folding
        "plugin:fold-cycle.nvim" = {
          url = "github:jghauser/fold-cycle.nvim";
          flake = false;
        };
        "plugin:pretty-fold.nvim" = {
          url = "github:anuvyklack/pretty-fold.nvim";
          flake = false;
        };
        # for preview of folds:
          "plugin:nvim-keymap-amend" = {
            url = "github:anuvyklack/nvim-keymap-amend";
            flake = false;
          };
      # "plugin:fzf.vim" = {
      #   url = "github:junegunn/fzf.vim";
      #   flake = false;
      # };
      "plugin:vim-commentary" = {
        url = "github:tpope/vim-commentary";
        flake = false;
      };
      "plugin:vim-visual-multi" = {
        url = "github:mg979/vim-visual-multi";
        flake = false;
      };
      "plugin:which-key.nvim" = {
        url = "github:folke/which-key.nvim";
        flake = false;
      };
      "plugin:vim-skeleton" = {
        url = "github:noahfrederick/vim-skeleton";
        flake = false;
      };
      "plugin:indent-blankline.nvim" = {
        url = "github:lukas-reineke/indent-blankline.nvim";
        flake = false;
      };
      "plugin:neoscroll.nvim" = {
        url = "github:karb94/neoscroll.nvim";
        flake = false;
      };
      "plugin:auto-session" = {
        url = "github:rmagatti/auto-session";
        flake = false;
      };
      # Cheatcheet
        "plugin:plenary.nvim" = {
          url = "github:nvim-lua/plenary.nvim";
          flake = false;
        };
        "plugin:telescope.nvim" = {
          url = "github:nvim-telescope/telescope.nvim";
          flake = false;
        };
        "plugin:popup.nvim" = {
          url = "github:nvim-lua/popup.nvim";
          flake = false;
        };
        "plugin:cheatsheet.nvim" = {
          url = "github:sudormrfbin/cheatsheet.nvim";
          flake = false;
        };
      # Buffer line
        "plugin:nvim-web-devicons" = {
           url = "github:kyazdani42/nvim-web-devicons";
           flake = false;
          };
        "plugin:barbar.nvim" = {
           url = "github:romgrk/barbar.nvim";
           flake = false;
         };
      # Note taking
        "plugin:nabla.nvim" = {
          url = "github:jbyuki/nabla.nvim";
          flake = false;
        };
      # marks
        "plugin:marks.nvim" = {
          url = "github:chentau/marks.nvim";
          flake = false;
        };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    # This line makes this package availeable for all systems
    # ("x86_64-linux", "aarch64-linux", "i686-linux", "x86_64-darwin",...)
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Once we add this overlay to our nixpkgs, we are able to
        # use `pkgs.neovimPlugins`, which is a map of our plugins.
        # Each input in the format:
        # ```
        # "plugin:yourPluginName" = {
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
              (s: (builtins.match "plugin:.*" s) != null)
              (builtins.attrNames inputs);
            plugName = input:
              builtins.substring
                (builtins.stringLength "plugin:")
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
        #          | "plugin:yourPluginName" = {
        #          |   url   = "github:exampleAuthor/examplePlugin";
        #          |   flake = false;
        #          | };
        #          | 
        #          | "plugin:anotherPluginYouLike" = {
        #          |   url   = "github:exampleAuthor/examplePlugin";
        #          |   flake = false;
        #          | };
        #          | ```
        #          | to your imports!
        # opt      | List of optional plugins to load only when 
        #          | explicitly loaded from inside neovim
        neovimBuilder = { customRC  ? ""
                        , viAlias   ? true
                        , vimAlias  ? true
                        , start     ? builtins.attrValues pkgs.neovimPlugins
                        , opt       ? []
                        , debug     ? false 
                        , depencies ? []}:
                        let
                          myNeovimUnwrapped = pkgs.neovim-unwrapped.overrideAttrs (prev: {
                            propagatedBuildInputs = with pkgs; [
                              # TODO find out why this is here
                              pkgs.stdenv.cc.cc.lib
                            ];
                            postInstall = ''
                              # runtime is in $out/share/nvim/runtime
                              # snippet stuff
                              mkdir -p $out/share/nvim/runtime/snippets
                              # TODO: These snippets do not get loaded yet :(
                              cp -r ${inputs.snippets-java} $out/share/nvim/runtime/snippets/snippets-java
                              cp -r ${inputs.snippets-shebang} $out/share/nvim/runtime/snippets/snippets-shebang
                              cp -r ${inputs.runtime}/* $out/share/nvim/runtime/
                            '';
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
                            paths = with pkgs; [
                              neovim-wrapped
                              # Language servers
                                # LaTex
                                  texlab
                                # Haskell
                                  haskell-language-server
                                  ormolu
                                # JavaScript / Typescript
                                  nodePackages.javascript-typescript-langserver
                                # NIX
                                  rnix-lsp
                                # Python
                                  python39Packages.jedi-language-server
                                # Rust
                                  rls
                                # Clojure
                                  clojure-lsp
                                # C
                                  clang-tools
                                # Cmake
                                  cmake-language-server
                                # Java
                                  jdk11
                                  java-language-server
                                # Lua
                                  sumneko-lua-language-server
                                # Dart
                                  dart
                              # Other dependencies
                                xclip
                                # Spelling and grammar
                                  languagetool
                            ] ++ depencies;
                            nativeBuildInputs = [ pkgs.makeWrapper ];
                            postBuild = ''
                              # Add ltex-ls
                              ln -sf ${inputs.ltex-ls}/bin/ltex-ls $out/bin/ltex-ls
                              wrapProgram $out/bin/ltex-ls \
                                --set JAVA_HOME ${pkgs.jdk11}
                              # add external dependencies to path of neovim
                              wrapProgram $out/bin/nvim \
                                --prefix PATH : $out/bin \
                                --set JAVA_HOME ${pkgs.jdk11} \
                                --set JDTLS_HOME ${inputs.runtime}/jdt-language-server
# /nix/store/ca5mg50y6hrx0klwnb7p6mjlnr4ihlm5-neovim-unwrapped-master/share/nvim/
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
                ++ [pkgs.vimPlugins.sniprun];
          depencies = with pkgs; [
            # Telescope
              fd
              ripgrep
              bat
            # Treesitter
              gcc
            toilet
            nodejs
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
