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

    environment.systemPackages = with pkgs; [
      (pkgs.dwmblocks.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          cp ${./blocks.h} blocks.def.h
          substituteInPlace dwmblocks.c \
            --replace "void termhandler()" "void termhandler(int signum)"
        '';
      }))
    ];

    services.xserver.videoDrivers = [ "amdgpu" ];
    services.libinput.enable = true;

    programs.dconf.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}
