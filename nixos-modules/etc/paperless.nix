{ ... }:
{
  services.paperless = {
    enable = true;
    consumptionDir = "/srv/ftp/scanner/input";
    settings = {
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
      PAPERLESS_FILENAME_FORMAT = "{{created_year}}/{{correspondent}}/{{title}}";
    };
  };
}
