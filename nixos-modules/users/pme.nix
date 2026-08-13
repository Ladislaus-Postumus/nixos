{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.users.pme.enable = mkEnableOption "allow user 'pme'";
  config = mkIf config.my.users.pme.enable {
    users.users.pme = {
      isNormalUser = true;
      description = "Philipp Melzer";
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "plugdev"
        "docker"
        "sftpusers"
        "input"
        "corectrl"
      ];
    };

    home-manager.users.pme = import ../../home/pme;
  };
}
