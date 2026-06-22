{
  inputs,
  pkgs,
  ...
}: let
  vimSpellDe = pkgs.runCommand "vim-spell-de" {} ''
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
in {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      searchCase = "smart";
      lazy.enable = true;
      git.enable = true;
      undoFile.enable = true;
      telescope.enable = true;
      treesitter.enable = true;

      clipboard = {
        enable = true;
        registers = "unnamed,unnamedplus";
      };

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

      statusline.lualine.enable = true;

      ui = {
        noice = {
          enable = true;
          setupOpts = {
            lsp = {
              hover.enabled = false;
              signature.enabled = false;
            };
            presets = {
              bottom_search = true;
              command_palette = true;
              long_message_to_split = true;
            };
          };
        };
      };

      luaConfigPost = ''
        vim.o.colorcolumn = "120"
        vim.o.conceallevel = 3
        vim.o.concealcursor = 'nc'

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, { border = "rounded" }
        )
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signatureHelp, { border = "rounded" }
        )

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          callback = function()
            vim.lsp.buf.clear_references()
          end,
        })

        local function smart_navigate(wincmd, tmux_direction)
          local initial_win = vim.api.nvim_get_current_win()
          vim.cmd("wincmd " .. wincmd)
          if initial_win == vim.api.nvim_get_current_win() then
            vim.fn.system("tmux select-pane -" .. tmux_direction)
          end
        end

        vim.keymap.set("n", "<C-h>", function() smart_navigate("h", "L") end)
        vim.keymap.set("n", "<C-j>", function() smart_navigate("j", "D") end)
        vim.keymap.set("n", "<C-k>", function() smart_navigate("k", "U") end)
        vim.keymap.set("n", "<C-l>", function() smart_navigate("l", "R") end)
      '';

      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;

        bash.enable = true;
        clang.enable = true;
        cmake.enable = true;
        json.enable = true;
        markdown.enable = true;
        nix.enable = true;
        rust.enable = true;
        toml.enable = true;
        yaml.enable = true;
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        trouble.enable = true;
      };

      diagnostics = {
        enable = true;
      };

      formatter.conform-nvim.enable = true;

      snippets = {
        luasnip.enable = true;
      };

      autocomplete.nvim-cmp = {
        enable = true;
        mappings = {
          complete = "<C-Space>";
          next = "<Tab>";
          previous = "<S-Tab>";
          confirm = "<CR>";
        };
        setupOpts = {
          window = {
            completion = {
              border = "rounded";
            };
            documentation = {
              border = "rounded";
            };
          };
        };
      };

      notes = {
        todo-comments.enable = true;
        neorg.enable = true;
      };

      utility = {
        ccc.enable = true;
        diffview-nvim.enable = true;
        undotree.enable = true;
        yazi-nvim.enable = true;
        yazi-nvim.setupOpts.open_for_directories = true;
      };

      terminal.toggleterm.enable = true;

      visuals = {
        fidget-nvim.enable = true;
        indent-blankline.enable = true;
        nvim-web-devicons.enable = true;
        rainbow-delimiters.enable = true;
      };

      mini = {
        tabline.enable = true;
        surround.enable = true;
        comment.enable = true;
        ai.enable = true;
      };

      binds.whichKey.enable = true;

      keymaps = [
        {
          mode = [
            "n"
            "i"
          ];
          key = "<C-q>";
          action = "vim.lsp.buf.hover";
          lua = true;
          silent = true;
          desc = "Hover Documentation";
        }
        {
          mode = "n";
          key = "<leader>xx";
          action = "<cmd>Trouble diagnostics toggle<cr>";
          desc = "Toggle Diagnostics (Trouble)";
        }
        {
          mode = "n";
          key = "<leader>xt";
          action = "<cmd>Trouble todo toggle<cr>";
          desc = "Toggle TODOs (Trouble)";
        }
      ];
    };
  };
}
