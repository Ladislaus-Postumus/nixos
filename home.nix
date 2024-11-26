{ pkgs, lib, ...}:

{
  imports = [
    ./home/sh.nix
    ./home/nvim.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim
    git
    wget
    nerdfonts
    gnumake
    gcc
    unzip
    ripgrep
    nushell
    starship
    zellij
    rustup
  ];

  programs.nushell.enable = true;
}
