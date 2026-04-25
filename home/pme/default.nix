{ pkgs, inputs, ... }:

{
  home.stateVersion = "25.11";

  imports = [ inputs.stylix.homeModules.stylix ./nvim.nix ];

  #programs.lutris.enable = true;

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets.xresources.enable = true;
    fonts = {
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.ubuntu-sans;
        name = "Ubuntu Sans";
      };
      serif = {
        package = pkgs.ubuntu-sans;
        name = "Ubuntu Sans";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 14;
        desktop = 12;
      };
    };
  };
}
