{
  pkgs,
  config,
  inputs,
  ...
}: {
  my.features.gnome.enable = true;
  my.features.gaming.enable = true;

  imports = [
    ./desktop-hardware.nix
    inputs.stylix.nixosModules.stylix
  ];
  networking.hostName = "v-latptop";
  system.stateVersion = "24.11";

  systemd.services.NetworkManager-wait-online.enable = false;
  zramSwap = {
    enable = true;
    priority = 100; # High priority: Use compressed RAM first
    memoryPercent = 50;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
      priority = 10; # Low priority: Only use when ZRAM is full
    }
  ];

  system.autoUpgrade = {
    enable = true;
    flake = "/home/pme/projects/nixos/";
    operation = "boot";
    dates = "daily";
  };
  systemd.services.nixos-upgrade.environment.NIXOS_LABEL = "auto-upgrade";
}
