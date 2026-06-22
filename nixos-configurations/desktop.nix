{
  pkgs,
  config,
  inputs,
  ...
}:
{
  my.features.dwm.enable = true;
  my.features.gnome.enable = false;
  my.features.hyprland.enable = false;

  my.features.astro.enable = true;
  my.features.gaming.enable = true;
  my.features.keyboard.enable = true;

  imports = [
    ./desktop-hardware.nix
    inputs.stylix.nixosModules.stylix
  ];
  networking.hostName = "desktop";
  system.stateVersion = "24.11";

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    pam_u2f
  ];

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

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  security.pam.u2f = {
    control = "sufficient";
    enable = true;
    settings.cue = true;
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/pme/nix-config/";
    operation = "boot";
    dates = "daily";
  };
}
