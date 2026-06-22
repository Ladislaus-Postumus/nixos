{}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1; # Start window numbering at 1 (closer to home row)
    escapeTime = 0; # Crucial: removes insertion latency/stutter in Neovim
    keyMode = "vi"; # Use vi keys in copy mode
    mouse = true; # Enable trackball/mouse interactions for panes

    # Manage plugins the Nix way—no mutable TPM required
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_tabs_enabled 'on'
        '';
      }
    ];

    extraConfig = ''
      -- Seamless Neovim/Tmux navigation grid (Matches your smart_navigate Lua script)
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      -- Ensure new panes and splits inherit your active working directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
