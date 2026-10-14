{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.wayland.enable = mkEnableOption "apps only for wayland systems";

  config = mkIf config.my.features.wayland.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      thunar
    ];
  };
}
