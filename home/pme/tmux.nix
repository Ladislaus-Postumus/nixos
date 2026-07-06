{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1; # Start window numbering at 1 (closer to home row)
    escapeTime = 0; # Crucial: removes insertion latency/stutter in Neovim
    keyMode = "vi"; # Use vi keys in copy mode
    mouse = true; # Enable trackball/mouse interactions for panes
    terminal = "tmux-256color";

    # Manage plugins the Nix way—no mutable TPM required
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
    ];

    extraConfig = let
      # Extract semantic color tokens from your current active Stylix scheme
      bg = "#${config.lib.stylix.colors.base00}"; # Default background
      statusBg = "#${config.lib.stylix.colors.base01}"; # Slightly lighter block
      fg = "#${config.lib.stylix.colors.base05}"; # Default text
      accent = "#${config.lib.stylix.colors.base0D}"; # Usually Blue (matches your dwm bar)
    in ''
      set -as terminal-features ",*:RGB"
      set -as terminal-features ",*:Styling"
      set -as terminal-overrides ",*:Tc"
      set -g default-command "bash"

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -sel clip -i"
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -sel clip -i"

      is_vim="ps -t '#{pane_tty}' | grep -iq nvim"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      set -g status-left-length 40
      set -g status-right-length 80
      set -g status-justify left

      # Apply the global status line colors dynamically
      set -g status-style "bg=${statusBg},fg=${fg}"

      # Powerline left section structure
      set -g status-left "#[fg=${bg},bg=${accent},bold] 󰄛 #S #[fg=${accent},bg=${statusBg},nobold]"

      # Powerline window tabs layout
      set -g window-status-current-format "#[fg=${statusBg},bg=${accent}]#[fg=${bg},bg=${accent},bold] #I:#W #[fg=${accent},bg=${statusBg},nobold]"
      set -g window-status-format "#[fg=${fg},bg=${statusBg}]  #I:#W  "

      # Powerline right section structure matching your date formatting
      set -g status-right "#[fg=${accent},bg=${statusBg}]#[fg=${bg},bg=${accent}] 󱫋 %H:%M #[fg=${bg},bg=${accent}]│ %d-%b-%y "

      setw -g monitor-activity on
      set -g visual-activity off
      set -g renumber-windows on
    '';
  };

  home.packages = [
    (pkgs.writeScriptBin "tmx" (builtins.readFile ./scripts/tmx.sh))
  ];
}
