{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    btop
    entr # command running file watcher
    eza
    fastfetch
    fido2-manage
    gdu
    p7zip
    procps # pgrep
    psmisc # killall
    ripgrep
    unzip
    yazi
    zip
    parallel
    github-cli
  ];
  programs.zsh.enable = true;
}
