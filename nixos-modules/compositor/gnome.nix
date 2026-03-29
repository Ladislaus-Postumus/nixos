{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.gnome.enable = mkEnableOption "enable gnome compositor";
  config = mkIf config.my.features.gnome.enable {
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    #services.displayManager.gdm.wayland = false;
    services.desktopManager.gnome.enable = true;

    services.gnome = {
      games.enable = false;
    };
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
    ];

    services.xserver.windowManager = {
      i3.enable = true;
    };

    services.xserver.videoDrivers = [
      "amdgpu"
      "intel"
    ];
    services.libinput.enable = true;
  };
}
