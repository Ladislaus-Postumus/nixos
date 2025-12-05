{
  inputs,
  pkgs,
  ...
}: let
  vimSpellDe = pkgs.runCommand "vim-spell-de" {} ''
    mkdir -p $out/share/vim/vimfiles/spell
    cp ${pkgs.fetchurl {
      url = "https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl";
      hash = "sha256-c8cQfqM5hWzb6SHeuSpFk5xN5uucByYdobndGfaDo9E=";
    }} $out/share/vim/vimfiles/spell/de.utf-8.spl
    cp ${pkgs.fetchurl {
      url = "https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.sug";
      hash = "sha256-E9Ds+Shj2J72DNSopesqWhOg6Pm6jRxqvkerqFcUqUg=";
    }} $out/share/vim/vimfiles/spell/de.utf-8.sug
  '';
in {
  imports = [
    inputs.nvf.nixosModules.default
  ];
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
      clipboard = {
        enable = true;
        registers = "unnamed,unnamedplus";
      };

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
        languages = ["en" "de"];
      };

      additionalRuntimePaths = [
        "${vimSpellDe}/share/vim/vimfiles"
      ];

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };

      lsp = {
        enable = true;
      };
      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;

        nix.enable = true;
        bash.enable = true;
      };

      diagnostics = {
        enable = true;
      };

      # TODO
      #formatter.conform-nvim.enable = false;
      #diagnostics.nvim-lint.enable = false;
      #debugger.nvim-dap.enable = false;

      # // TODO //
      # autocomplete.blink-cmp = {
      #   enable = false;
      # };

      visuals = {
        indent-blankline.enable = true;
        nvim-cursorline.enable = true;
        #nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        rainbow-delimiters.enable = true;
        tiny-devicons-auto-colors.enable = true;
        fidget-nvim.enable = true; # progress/lsp-progress message handler
        highlight-undo.enable = true;
        cinnamon-nvim.enable = true; # smooth scrolling
        cellular-automaton.enable = true;
      };

      binds.whichKey.enable = true;

      utility = {
        #yanky-nvim.enable = true;
        #yanky-nvim.setupOpts.ring.storage = "memory";
        undotree.enable = true;
        smart-splits.enable = true;
        outline.aerial-nvim.enable = true;
        yazi-nvim.enable = true;
        # motion.precognition.enable = true; # discovers motions (good for beginners), mostly annoying due to blank line
        #   # TODO test, choose one? / choose mini
        #   motion.leap.enable = false;
        #   motion.hop.enable = false;
        #   motion.flash-nvim.enable = false;
        # vim-wakatime.enable = true; # tracks time und loc TODO
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

      # terminal.toggleterm.enable = true;
      # projects.project-nvim.enable = true;
      # notes.neorg.enable = true;
      # navigation.harpoon.enable = true;

      mini = {
        ai.enable = true;
        align.enable = true;
        #   animate.enable = true;
        #   basics.enable = true;
        #   bracketed.enable = true;
        #   bufremove.enable = true;
        # clue.enable = true;
        # clue.setupOpts = {
        #   clues = [
        #     { mode = "n"; triggers = [ "<leader>" ]; }
        #   ];
        # };
        #   colors.enable = true;
        comment.enable = true;
        completion.enable = true;
        #   cursorword.enable = true;
        #   diff.enable = true;
        #   doc.enable = false;
        #   extra.enable = true;
        #   files.enable = true;
        #   fuzzy.enable = true;
        #   git.enable = true;
        #   hipatterns.enable = true;
        #   hues.enable = false;
        #   icons.enable = true;
        #   indentscope.enable = true;
        #   jump.enable = true;
        #   jump2d.enable = true;
        #   map.enable = true;
        #   misc.enable = true;
        #   move.enable = true;
        #   notify.enable = true;
        #   operators.enable = true;
        #   pairs.enable = true;
        #   pick.enable = true;
        #   sessions.enable = true;
        #   snippets.enable = true;
        #   splitjoin.enable = true;
        #   starter.enable = false;
        statusline.enable = true;
        #   surround.enable = true;
        tabline.enable = true;
        #   test.enable = false;
        #   trailspace.enable = true;
        #   visits.enable = true;
      };
    };
  };
}
