{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.TODO.enable = mkEnableOption "apps to look at";

  config = mkIf config.my.features.TODO.enable {
    environment.systemPackages = with pkgs; [
      newsboat
      wakapi
      wakatime-cli
      taskwarrior2
      bitwarden-cli
      bitwarden-menu
      bitwarden-desktop
    ];
  };
}
