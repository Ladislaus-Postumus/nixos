{...}:
{
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      undoFile.enable = true;
      treesitter.enable = true;
      syntaxHighlighting = true;
      telescope.enable = true;
      lazy.enable = true;
      git.enable = true;
      fzf-lua.enable = true;
      clipboard.enable = false;

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
        languages = [ "en" "de" ];
      };

      theme = {
        enable = true;
        name = "everforest";
        style = "medium";
        transparent = true;
      };

      lsp = {
        enable = true;
      };

      # TODO
      #formatter.conform-nvim.enable = false;
      #diagnostics.nvim-lint.enable = false;
      #debugger.nvim-dap.enable = false;

      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;

        nix.enable = true;
      };

      # TODO
      autocomplete.blink-cmp = {
        enable = false;
      };

      visuals = {
        indent-blankline.enable = true;
        nvim-cursorline.enable = true;
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        rainbow-delimiters.enable = true;
        tiny-devicons-auto-colors.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        cinnamon-nvim.enable = true;
        cellular-automaton.enable = true;
      };

      utility = {
        yanky-nvim.enable = true;
        yanky-nvim.setupOpts.ring.storage = "memory";
        snacks-nvim.enable = true;
        undotree.enable = true;
        vim-wakatime.enable = true;
        smart-splits.enable = true;
        outline.aerial-nvim.enable = true;
        preview.glow.enable = true;
        oil-nvim.enable = true;
        new-file-template.enable = true;
        motion.precognition.enable = true;
        # TODO test, choose one? / choose mini
        motion.leap.enable = false;
        motion.hop.enable = false;
        motion.flash-nvim.enable = false;
        #
        mkdir.enable = true;
        diffview-nvim.enable = true;
        icon-picker.enable = true;
        images.image-nvim.enable = true;
        images.image-nvim.setupOpts.backend = "kitty";
        ccc.enable = true;
      };

      ui = {
        nvim-ufo.enable = true;
        smartcolumn.enable = true;
        noice.enable = true;
        fastaction.enable = true;
        illuminate.enable = true;
        modes-nvim.enable = true;
        breadcrumbs.enable = true;
        colorful-menu-nvim.enable = true;
        colorizer.enable = true;
      };

      runner.run-nvim.enable = true;

      snippets = {
        luasnip.enable = true;
      };

      # TODO compare with mini
      statusline.lualine.enable = false;
      tabline.nvimBufferline.enable = false;

      terminal.toggleterm.enable = true;
      projects.project-nvim.enable = true;
      notes.neorg.enable = true;
      navigation.harpoon.enable = true;

      mini = {
        ai.enable = true;
        align.enable = true;
        animate.enable = true;
        basics.enable = true;
        bracketed.enable = true;
        bufremove.enable = true;
        clue.enable = true;
        colors.enable = true;
        comment.enable = true;
        completion.enable = true;
        cursorword.enable = true;
        diff.enable = true;
        doc.enable = false;
        extra.enable = true;
        files.enable = true;
        fuzzy.enable = true;
        git.enable = true;
        hipatterns.enable = true;
        hues.enable = false;
        icons.enable = true;
        indentscope.enable = true;
        jump.enable = true;
        jump2d.enable = true;
        map.enable = true;
        misc.enable = true;
        move.enable = true;
        notify.enable = true;
        operators.enable = true;
        pairs.enable = true;
        pick.enable = true;
        sessions.enable = true;
        snippets.enable = true;
        splitjoin.enable = true;
        starter.enable = false;
        statusline.enable = true;
        surround.enable = true;
        tabline.enable = true;
        test.enable = false;
        trailspace.enable = true;
        visits.enable = true;
      };
    };
  };
}
