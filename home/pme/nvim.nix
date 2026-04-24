{
  inputs,
  pkgs,
  ...
}:
let
  vimSpellDe = pkgs.runCommand "vim-spell-de" { } ''
    mkdir -p $out/share/vim/vimfiles/spell
    cp ${
      pkgs.fetchurl {
        url = "https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl";
        hash = "sha256-c8cQfqM5hWzb6SHeuSpFk5xN5uucByYdobndGfaDo9E=";
      }
    } $out/share/vim/vimfiles/spell/de.utf-8.spl
    cp ${
      pkgs.fetchurl {
        url = "https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.sug";
        hash = "sha256-E9Ds+Shj2J72DNSopesqWhOg6Pm6jRxqvkerqFcUqUg=";
      }
    } $out/share/vim/vimfiles/spell/de.utf-8.sug
  '';
in
{

  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;
    settings.vim = {
      clipboard = {
        enable = true;
        registers = "unnamed,unnamedplus";
      };
      git.enable = true;
      lazy.enable = true;
      searchCase = "smart";
      telescope.enable = true;
      treesitter.enable = true;
      undoFile.enable = true;
      viAlias = true;
      vimAlias = true;

      luaConfigPost = ''
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        vim.o.shiftwidth=2
        vim.o.softtabstop=2
        vim.o.tabstop=2
      '';

      spellcheck = {
        enable = true;
        languages = [
          "en"
          "de"
        ];
      };

      additionalRuntimePaths = [
        "${vimSpellDe}/share/vim/vimfiles"
      ];

      lsp = {
        enable = true;
        #lspSignature.enable = true;
        lspkind.enable = true;
        lspsaga.enable = true;
        null-ls.enable = true;
        trouble.enable = true;
      };
      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;

        # lsp languages
        bash.enable = true;
        clang.enable = true;
        cmake.enable = true;
        json.enable = true;
        nix.enable = true;
        qml.enable = true;
        rust.enable = true;
        sql.dialect = "oracle";
        sql.enable = true;
        toml.enable = true;
        yaml.enable = true;
      };

      diagnostics = {
        enable = true;
        nvim-lint.enable = true;
      };

      formatter.conform-nvim.enable = true;
      #debugger.nvim-dap.enable = false;

      autocomplete.blink-cmp = {
        enable = true;
      };

      visuals = {
        indent-blankline.enable = true;
        nvim-cursorline.enable = true;
        nvim-web-devicons.enable = true;
        rainbow-delimiters.enable = true;
        tiny-devicons-auto-colors.enable = true;
        fidget-nvim.enable = true; # progress/lsp-progress message handler
        highlight-undo.enable = true;
        cellular-automaton.enable = true;
      };

      binds.whichKey.enable = true;

      utility = {
        undotree.enable = true;
        smart-splits.enable = true;
        outline.aerial-nvim.enable = true;
        yazi-nvim.enable = true;
        yazi-nvim.setupOpts.open_for_directories = true;

        #   motion.flash-nvim.enable = false;
        # vim-wakatime.enable = true; # tracks time und loc TODO
        mkdir.enable = true;
        diffview-nvim.enable = true;
        icon-picker.enable = true;
        images.image-nvim.enable = true;
        images.image-nvim.setupOpts.backend = "kitty";
      };

      ui = {
        nvim-ufo.enable = true;
        smartcolumn.enable = true;

        noice = {
          enable = true;
          setupOpts = {
            lsp = {
              hover = {
                enabled = true;
                view = "popup";
              };
              signature = {
                enabled = true;
                view = "popup";
              };
              documentation = {
                enabled = true;
                view = "popup";
              };
            };
            views = {
              popup = {
                size = {
                  max_width = 120;
                  max_height = 40;
                };
              };
            };
            presets = {
              lsp_doc_border = true;
            };
          };
        };

        fastaction.enable = true;
        illuminate.enable = true;
        breadcrumbs.enable = true;
        colorful-menu-nvim.enable = true;
        colorizer.enable = true;
      };

      notes = {
        todo-comments = {
          enable = true;
          mappings.telescope = "<leader>tds";
        };
      };

      # runner.run-nvim.enable = true; # runs code in editor; todo want that?

      terminal.toggleterm.enable = true;

      snippets = {
        luasnip.enable = true;
      };

      mini = {
        ai.enable = true;
        align.enable = true;
        comment.enable = true;
        #   cursorword.enable = true;
        #   diff.enable = true;
        #   doc.enable = false;
        #   extra.enable = true;
        #   git.enable = true;
        #   hipatterns.enable = true;
        #   hues.enable = false;
        #   icons.enable = true;
        #   notify.enable = true;
        #   operators.enable = true;
        pairs.enable = true;
        #   pick.enable = true;
        #   splitjoin.enable = true;
        statusline.enable = true;
        surround.enable = true;
        tabline.enable = true;
        #   test.enable = false;
        #   trailspace.enable = true;
        #   visits.enable = true;
      };

      assistant.codecompanion-nvim = {
        enable = true;
        setupOpts = {
          adapters.ollama = "ollama";

          strategies = {
            chat.adapter = "ollama";
            inline.enabled = false;
          };

          opts = {
            adapter_options = {
              ollama = {
                model = "qwen2.5-coder:7b";
              };
            };
            system_prompt = ''
              You are an expert programming consultant. 
              NEVER provide code aimed at full file replacement. 
              Provide concise, highly logical snippets and explain the 'why'. 
              I prefer to type the code myself to ensure I understand it.
            '';
          };

          display.chat = {
            window = {
              layout = "vertical";
              width = 0.35;
            };
          };
        };
      };

      keymaps = [
        {
          mode = "n";
          key = "<C-q>";
          action = "vim.lsp.buf.hover";
          lua = true;
          silent = true;
        }
        {
          mode = "i";
          key = "<C-q>";
          action = "vim.lsp.buf.hover";
          lua = true;
          silent = true;
        }
        {
          mode = "n";
          key = "<leader>aaa";
          action = ":CellularAutomaton game_of_life";
        }
        {
          key = "<leader>ac";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>CodeCompanionChat Toggle<cr>";
          desc = "AI Chat (Consultant Mode)";
        }
        {
          key = "<leader>aa";
          mode = [
            "n"
            "v"
          ];
          action = "<cmd>CodeCompanionActions<cr>";
          desc = "AI Actions (Explain/LSP/etc)";
        }
      ];
    };
  };
}
