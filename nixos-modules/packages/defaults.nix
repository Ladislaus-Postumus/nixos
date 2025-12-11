{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kitty
    neovim
    git
    lazygit
    wl-clipboard
    firefox
    keepassxc
    fzf
    bat
    eza
    starship
    yazi
    zip
    unzip
    mpv
    feh
    syncthing
    discord
    asciiquarium
    cowsay
  ];
}
