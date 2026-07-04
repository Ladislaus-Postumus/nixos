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

    extraConfig = ''
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

      set -g status-left " 󰄛 #S │ "
      set -g status-right "󱫋 %H:%M │ %d-%b-%y "

      set -g window-status-format " #I:#W "
      set -g window-status-current-format " #[bold]#I:#W* "

      setw -g monitor-activity on
      set -g visual-activity off
      set -g renumber-windows on
    '';
  };

  home.packages = [
    (pkgs.writeScriptBin "tmx" (builtins.readFile ./scripts/tmx.sh))
  ];
}
