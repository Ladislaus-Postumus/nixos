{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    asciiquarium
    bat
    btop
    cowsay
    discord
    easyeffects
    espanso-wayland
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
    ripgrep
    starship
    syncthing
    unzip
    wl-clipboard
    thunar
    yazi
    zip
    zoxide

    nitrokey-app2
    fido2-manage

    omnissa-horizon-client
    discord-canary

    adwaita-fonts
    adwaita-icon-theme
    catppuccin-qt5ct
    libsForQt5.qt5ct
    kdePackages.qt6ct
    hicolor-icon-theme

    hledger

    i3status-rust
    redshift
    rofi
    dunst
    xclip
    haskellPackages.greenclip
    flameshot
    picom
    xdotool
    libnotify
    polkit_gnome
  ];

  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true;
}
