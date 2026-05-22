{...}: {
  fileSystems."/mnt/astro" = {
    device = "/dev/disk/by-label/AstroDisk";
    fsType = "xfs";
  };
}
