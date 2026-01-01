{pkgs, ...}: {
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
  ];
}
