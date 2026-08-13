{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.users.tech.enable = mkEnableOption "allow technichal users";
  config = mkIf config.my.users.tech.enable {
    users.users.guest = {
      isNormalUser = true;
      description = "Guest";
      extraGroups = [];
    };

    users.users.scanner = {
      isSystemUser = true;
      createHome = false;
      home = "/srv/ftp/scanner";
      group = "ftpusers";
      extraGroups = ["paperless"];
    };
  };
}
