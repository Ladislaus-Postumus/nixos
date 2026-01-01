{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.hyprland.enable = mkEnableOption "enable hyprland compositor";
  config = mkIf config.my.features.hyprland.enable {
    environment.systemPackages = with pkgs; [
      hyprsunset
      waybar
      wofi
      hyprpolkitagent
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    xdg.portal = {
      enable = true;
      # CRITICAL: Explicitly lists portals to enforce priority (XDPH first, GTK second).
      # This prevents the heavier Gnome portal from interfering in the Hyprland session.
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland # Hyprland specific features (screensharing) [2]
        xdg-desktop-portal-gtk # Provides the essential generic file picker backend [2];
      ];
    };

    programs.hyprlock.enable = true;
    services.hypridle.enable = true;

    services.displayManager.defaultSession = "hyprland-uwsm";
  };
}
