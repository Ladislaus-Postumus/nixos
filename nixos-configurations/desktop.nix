{ pkgs, config, inputs, ... }:
{
  my.features.dwm.enable = true;
  my.features.gnome.enable = false;
  my.features.hyprland.enable = false;

  my.features.astro.enable = false;
  my.features.gaming.enable = true;
  my.features.keyboard.enable = true;

  imports = [ ./desktop-hardware.nix inputs.stylix.nixosModules.stylix ];
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

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = config.lib.stylix.pixel "base0A";
  };
}
