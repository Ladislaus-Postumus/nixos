{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.astro.enable = mkEnableOption "apps for (astro) photo editing";

  config = mkIf config.my.features.astro.enable {
    environment.systemPackages = with pkgs; [
      gimp3
      siril
      exiftool
    ];
  };
}
