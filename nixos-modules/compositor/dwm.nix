{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.my.features.dwm.enable = mkEnableOption "enable dwm window manager";
  config = mkIf config.my.features.dwm.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.startx.enable = true;
    services.xserver.windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          cp ${./config.h} config.h
        '';
      });
    };

    services.xserver.videoDrivers = [ "amdgpu" ];
    services.libinput.enable = true;

    #services.xserver.displayManager.lightdm.enable = false;
  };
}
