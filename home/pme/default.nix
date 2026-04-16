{pkgs, inputs, ...}: {
  home.stateVersion = "25.11";

  imports = [inputs.stylix.homeModules.stylix];

  programs.lutris.enable = true;

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets.xresources.enable = true;
  };
}
