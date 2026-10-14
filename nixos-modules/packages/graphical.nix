{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.graphical.enable = mkEnableOption "apps for graphical systems/entertainment";

  config = mkIf config.my.features.graphical.enable {
    environment.systemPackages = with pkgs; [
      discord
      dunst # todo: home-manager? // listens to notify events and displays
      easyeffects # todo: configure
      feh # images
      firefox
      keepassxc
      kitty
      libnotify # api/lib that provides notify-send events
      mpv # video
      nitrokey-app2
      pamixer # cli audio controls (mute, up, down, etc)
      playerctl # cli media controller (play/pause, next)
      polkit_gnome
      proton-vpn
      ungoogled-chromium
    ];

    services.upower.enable = true;
    security.polkit.enable = true;
  };
}
