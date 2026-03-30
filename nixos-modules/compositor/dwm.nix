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
    services.xserver.windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          cp ${./config.h} config.h
        '';
      });
    };
  };
}
