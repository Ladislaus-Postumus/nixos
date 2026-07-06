{
  pkgs,
  config,
  ...
}: {
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
      bg = "#${config.lib.stylix.colors.base00}";
      statusBg = "#${config.lib.stylix.colors.base01}";
      fg = "#${config.lib.stylix.colors.base05}";
      accent2 = "#${config.lib.stylix.colors.base0D}";
    in ''
      # === Define Status Bar using System theme ===
      set -g status-style "bg=${statusBg},fg=${fg}"
      set -g status-left "#[fg=${bg},bg=${accent2},bold] 󰄛 #S #[fg=${accent2},bg=${statusBg},nobold]"
      set -g window-status-current-format "#[fg=${statusBg},bg=${bg}]#[fg=${accent2},bg=${bg},bold] #I:#W #[fg=${bg},bg=${statusBg},nobold]"
      set -g window-status-format "#[fg=${fg},bg=${statusBg}]  #I:#W  "
      set -g status-right "#[fg=${accent2},bg=${statusBg}]#[fg=${bg},bg=${accent2}] 󰄛 %H:%M #[fg=${bg},bg=${accent2}]│ %d-%b-%y "

      # === BEHAVIOUR & KEYBINDS ===
      ${builtins.readFile ./tmux.conf}
    '';
  };

  home.packages = [
    (pkgs.writeScriptBin "tmx" (builtins.readFile ./scripts/tmx.sh))
    (pkgs.writeScriptBin "tmux-jj" (builtins.readFile ./scripts/tmux-jj.sh))
  ];
}
