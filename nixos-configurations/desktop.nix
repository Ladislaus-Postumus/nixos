{ pkgs, ... }:
{
  my.features.gaming.enable = true;
  my.features.astro.enable = false;
  my.features.gnome.enable = true;
  my.features.hyprland.enable = true;
  my.features.keyboard.enable = true;

  imports = [ ./desktop-hardware.nix ];
  networking.hostName = "desktop";
  system.stateVersion = "24.11";

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    pam_u2f
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
}
