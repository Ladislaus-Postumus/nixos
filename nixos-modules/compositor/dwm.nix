{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.dwm.enable = mkEnableOption "enable dwm window manager";
  config = mkIf config.my.features.dwm.enable {
    nixpkgs.overlays = [
      (final: prev: {
        dwm = prev.dwm.overrideAttrs (_: {
          src = inputs.dwm-custom;
        });
        dwmblocks = prev.dwmblocks.overrideAttrs (_: {
          src = inputs.dwmblocks-custom;
        });
        dmenu = prev.dmenu.overrideAttrs (_: {
          src = inputs.dmenu-custom;
        });
        st = prev.st.overrideAttrs (_: {
          src = inputs.st-custom;
        });
      })
    ];

    services.xserver.enable = true;
    services.xserver.displayManager.startx.enable = true;
    services.xserver.windowManager.dwm.enable = true;

    environment.systemPackages = [
      pkgs.dwmblocks
      pkgs.dmenu
      pkgs.st
    ];

    services.xserver.videoDrivers = ["amdgpu"];
    services.libinput.enable = true;

    programs.dconf.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
  };
}
