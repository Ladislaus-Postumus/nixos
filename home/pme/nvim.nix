{
  inputs,
  pkgs,
  lib,
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

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.nvf = {
    enable = true;
    settings.vim = {
      extraPackages = [pkgs.gdtoolkit_4];

      viAlias = true;
      vimAlias = true;
      searchCase = "smart";
      lazy.enable = true;
      git.enable = true;
      git.gitsigns.setupOpts = lib.generators.mkLuaInline "{ signcolumn = false }";
      undoFile.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      treesitter.context.enable = true;
      treesitter.context.setupOpts.max_lines = 3;

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

      statusline.lualine = {
        enable = true;
        setupOpts = {
          options = {
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "";
              right = "";
            };
            disabled_filetypes.statusline = ["NvimTree" "TelescopePrompt"];
          };
          sections = {
            lualine_a = ["mode"];
            lualine_b = ["branch" "diff" "diagnostics"];
            lualine_c = ["filename"];
            lualine_x = ["encoding" "fileformat" "filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
          tabline = lib.generators.mkLuaInline ''
            {
              lualine_a = { { 'buffers', mode = 4 } },
              lualine_z = { { 'tabs', mode = 2 } },
            }
          '';
        };
      };

      ui = {
        noice = {
          enable = true;
          setupOpts = {
            lsp = {
              hover.enabled = true;
              signature.enabled = true;
            };
            presets = {
              bottom_search = true;
              command_palette = true;
              long_message_to_split = true;
              lsp_doc_border = true;
            };
            views = {
              hover = {
                border = {style = "rounded";};
                win_options = {
                  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder";
                  winblend = 0;
                };
              };
            };
          };
        };
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
      };

      luaConfigPost = ''
        vim.o.colorcolumn = "120"
        vim.o.conceallevel = 3
        vim.o.concealcursor = 'nc'

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

        -- assigns a separate colour to float/floatborder from stylix so noice hover panes look better
        vim.api.nvim_create_autocmd("ColorScheme", {
          callback = function()
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = vim.g.base16_gui01 })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = vim.g.base16_gui03, bg = vim.g.base16_gui01 })
          end,
        })
        vim.cmd("doautocmd ColorScheme")
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
        config = {
          virtual_text = false;
          underline = true;
          signs = lib.generators.mkLuaInline ''
            {
              text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
              },
            }
          '';
          severity_sort = true;
          update_in_insert = false;
          float = {
            border = "none";
            source = "always";
          };
        };
      };

      formatter.conform-nvim = {
        enable = true;
        setupOpts = {
          formatters_by_ft = {
            gd = ["gdformat"];
          };
        };
      };

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
        vim-wakatime.enable = true;
      };

      terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };

      visuals = {
        fidget-nvim.enable = true;
        indent-blankline.enable = true;
        nvim-web-devicons.enable = true;
        rainbow-delimiters.enable = true;
      };

      mini = {
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
        {
          mode = "n";
          key = "<leader>e";
          action = "vim.diagnostic.open_float";
          lua = true;
          silent = true;
          desc = "Show line diagnostics";
        }
        {
          mode = "n";
          key = "<leader>gt";
          action = "<cmd>Gitsigns toggle_signs<cr>";
          desc = "Toggle Git Signs";
        }
        {
          mode = "n";
          key = "<leader>n";
          action = "<cmd>Navbuddy<cr>";
          desc = "Navbuddy";
        }
      ];

      luaConfigRC.gdscript-lsp = ''
        vim.lsp.config('gdscript', {
          cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
          root_markers = { 'project.godot', '.git' },
        })
        vim.lsp.enable('gdscript')
      '';
    };
  };
}
