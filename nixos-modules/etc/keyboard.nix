{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.keyboard.enable = mkEnableOption "use zsa keyboard";

  config = mkIf config.my.features.keyboard.enable {
    environment.systemPackages = with pkgs; [
      keymapp
    ];

    hardware.keyboard.zsa.enable = true;
  };
}
