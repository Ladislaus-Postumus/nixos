{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    asciiquarium
    bat
    cowsay
    discord
    eza
    fastfetch
    feh
    firefox
    fzf
    git
    keepassxc
    kitty
    lazygit
    mpv
    neovim
    starship
    syncthing
    unzip
    wl-clipboard
    xfce.thunar
    yazi
    zip
    espanso-wayland
    zoxide

    omnissa-horizon-client

    adwaita-fonts
    adwaita-icon-theme
    catppuccin-qt5ct
    libsForQt5.qt5ct
    kdePackages.qt6ct
    hicolor-icon-theme

    hledger
  ];

  nixpkgs.config.allowUnfree = true;
}
