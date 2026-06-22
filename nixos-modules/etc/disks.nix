{ ... }:
{
  fileSystems."/mnt/astro" = {
    device = "/dev/disk/by-label/AstroDisk";
    fsType = "xfs";
  };

  systemd.tmpfiles.rules = [
    # "d" means directory, "0755" permissions, "pme" user, "users" group
    "d /mnt/astro 0755 pme users -"
  ];
}
