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
      set -as terminal-features ",xterm-256color:RGB"
      set -as terminal-features ",xterm-256color:Styling"
      set -g default-command "bash"

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
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
}
