{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # literally no fucking clue if/why i need those
    # added stylix.autoEnable, let's see how it goes
    # adwaita-fonts
    # adwaita-icon-theme
    # catppuccin-qt5ct
    # libsForQt5.qt5ct
    # kdePackages.qt6ct
    # hicolor-icon-theme
  ];
}
