{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.gaming.enable = mkEnableOption "apps for gaming";

  config = mkIf config.my.features.gaming.enable {
    environment.systemPackages = with pkgs; [
      heroic
      prismlauncher
      lutris
      pciutils
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    boot.kernelParams = ["amdgpu.ppfeaturemask=0xffffffff"];
    programs.corectrl.enable = true;
  };
}
