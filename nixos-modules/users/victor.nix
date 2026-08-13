{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.users.victor.enable = mkEnableOption "allow user 'victor'";
  config = mkIf config.my.users.victor.enable {
    users.users.pme = {
      isNormalUser = true;
      description = "Victor";
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
      ];
    };

    #home-manager.users.pme = import ../../home/victor;
  };
}
