{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.users.pme.enable = mkEnableOption "allow user 'pme'";
  options.my.home.pme.enable = mkEnableOption "home-manager for pme" // {default = true;};

  config = mkIf config.my.users.pme.enable {
    users.users.pme = {
      isNormalUser = true;
      description = "Philipp Melzer";
      shell =
        if config.my.home.pme.enable
        then pkgs.zsh
        else pkgs.bash;
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "plugdev"
        "docker"
        "sftpusers"
        "input"
      ];
    };

    home-manager.users = mkIf config.my.home.pme.enable {
      pme = import ../../home/pme;
    };
  };
}
