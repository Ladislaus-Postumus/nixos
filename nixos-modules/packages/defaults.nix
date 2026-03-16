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
    ripgrep

    nitrokey-app2
    fido2-manage

    omnissa-horizon-client

    adwaita-fonts
    adwaita-icon-theme
    catppuccin-qt5ct
    libsForQt5.qt5ct
    kdePackages.qt6ct
    hicolor-icon-theme

    hledger

    orca
  ];

  services.speechd.enable = true;
  users.extraUsers.pme.packages = with pkgs; [ speechd ];

  environment.etc."speech-dispatcher/speechd.conf".text = ''
    DefaultModule espeak
  '';

  nixpkgs.config.allowUnfree = true;
}
