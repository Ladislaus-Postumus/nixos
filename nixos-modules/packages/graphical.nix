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

    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true; # loads v4l2loopback and sets up polkit
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval # virtual green screen
        # wlrobs                    # screen capture on wlroots compositors (Sway/Hyprland)
        # obs-pipewire-audio-capture
      ];
    };
  };
}
