{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.mounts.astro.enable = mkEnableOption "mount a xfs disk labelled AstroDisk";
  config = mkIf config.my.mounts.astro.enable {
    fileSystems."/mnt/astro" = {
      device = "/dev/disk/by-label/AstroDisk";
      fsType = "xfs";
    };

    systemd.tmpfiles.rules = [
      "d /mnt/astro 0755 pme users -"
    ];
  };
}
