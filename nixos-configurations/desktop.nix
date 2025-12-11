{...}: {
  my.features.gaming.enable = true;
  my.features.astro.enable = true;
  my.features.gnome.enable = true;
  my.features.keyboard.enable = true;

  imports = [./desktop-hardware.nix];
  networking.hostName = "desktop";
  system.stateVersion = "24.11";

  virtualisation.docker.enable = true;
}
