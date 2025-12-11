{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.keyboard.enable = mkEnableOption "use zsa keyboard";

  config = mkIf config.my.features.gaming.enable {
    environment.systemPackages = with pkgs; [
      keymapp
    ];

    services.udev.extraRules = ''
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="1977", MODE="0660", GROUP="plugdev"
    '';
  };
}
