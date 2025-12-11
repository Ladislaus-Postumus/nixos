{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.gnome.enable = mkEnableOption "enable gnome compositor";
  config = mkIf config.my.features.gnome.enable {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.gnome = {
      games.enable = false;
    };
    environment.gnome.excludePackages = with pkgs; [gnome-tour gnome-user-docs];
  };
}
