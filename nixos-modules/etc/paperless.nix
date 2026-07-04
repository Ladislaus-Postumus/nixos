{pkgs, ...}: {
  services.paperless = {
    enable = true;
    consumptionDir = "/srv/ftp/scanner/input";
    settings = {
      PAPERLESS_OCR_LANGUAGE = "deu";
      PAPERLESS_FILENAME_FORMAT = "{{created_year}}/{{correspondent}}/{{title}}";
    };
  };
}
