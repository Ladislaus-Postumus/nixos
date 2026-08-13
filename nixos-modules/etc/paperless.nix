{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.paperless.enable = mkEnableOption "unlock tcp port 21 for ftp";
  config = mkIf config.my.features.paperless.enable {
    my.features.ftp.enable = true;
    services.paperless = {
      enable = true;
      consumptionDir = "/srv/ftp/scanner/input";
      settings = {
        PAPERLESS_OCR_LANGUAGE = "deu";
        PAPERLESS_FILENAME_FORMAT = "{{created_year}}/{{correspondent}}/{{title}}";
      };
    };
  };
}
