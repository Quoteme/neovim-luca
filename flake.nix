{
  description = "Luca's simple Neovim flake for easy configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/flake-utils";
    };
    # This section will allow us to create a python environment
    # with specific predefined python packages from PyPi
    pypi-deps-db = {
      url = "github:DavHau/mach-nix/3.3.0";
    };
    mach-nix = {
      url = "github:DavHau/mach-nix/3.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pypi-deps-db.follows = "pypi-deps-db";
    };

    # --- Neovim and plugins section ---

    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Theme
      "plugin:onedark-vim" = {
        url = "github:joshdick/onedark.vim";
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
    # General help
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
          "plugin:vim-vsnip" = {
            url = "github:hrsh7th/vim-vsnip";
            flake = false;
          };
          # Snippets
            "plugin:cmp-vsnip" = { # TODO add custom snippts
              url = "github:hrsh7th/cmp-vsnip";
              flake = false;
            };
            "plugin:friendly-snippets" = { # TODO add custom snippts
              url = "github:rafamadriz/friendly-snippets";
              flake = false;
            };
      "plugin:vim-slime" = {
        url = "github:jpalardy/vim-slime";
        flake = false;
      };
      "plugin:vim-signify" = {
        url = "github:mhinz/vim-signify";
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
      # Chearcheet
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
        "plugin:gkeep.nvim" = {
          url = "github:stevearc/gkeep.nvim";
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

        # Set up a python environment, because some plugins
        # (like gkeep.nvim) require python with specific packages.
        # simply create a new python enviroment using
        # ```
        # (mach.mkPython {
        #   requirements = ''
        #     putYourDependenciesHere
        #   '';
        # })
        # ```
        python = "python310";
        mach = import inputs.mach-nix { inherit pkgs python; };
        # create a custom python environment

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
                          neovim-withExternalDependencies = neovim-wrapped.overrideAttrs (prev: {
                            # here we add some external programs to neovim
                            # which means that neovim will be installed
                            # in a way that also installs these programs.
                            # This also means, that neovim can call them
                            # even if the user has not installed them
                            # system-wide
                            buildInputs = with pkgs; [
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
                                  pyright
                                # Rust
                                  rls
                                # Clojure
                                  clojure-lsp
                                # C
                                  clang-tools
                              # Other dependencies
                                xclip
                              ]
                              # finally load some extra depencies which
                              # can be passed as arguments to neovimBuilder
                              ++ depencies;
                          });
                        in
                        neovim-withExternalDependencies;
                        
      in
      rec {
        defaultApp = apps.nvim;
        defaultPackage = packages.neovimLuca;

        apps.nvim = {
            type = "app";
            program = "${defaultPackage}/bin/nvim";
          };

        packages.neovimLuca = neovimBuilder {
          # the next line loads a trivial example of a init.vim:
          customRC = pkgs.lib.readFile ./init.vim;
          depencies = with pkgs; [
            # Telescope
              fd
              ripgrep
              bat
            # gkeep.nvim
            (mach.mkPython {
              requirements = ''
                gkeepapi
                keyring==18.0.1
              '';
            })
            toilet
          ];
          # if you wish to only load the onedark-vim colorscheme:
          # start = with pkgs.neovimPlugins; [ onedark-vim ];
        };
      }
    );
}
