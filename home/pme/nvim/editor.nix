{lib, ...}: {
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

  assistant.codecompanion-nvim.enable = true;
}
