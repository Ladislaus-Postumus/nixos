{ ... }:
{
  services.paperless = {
    enable = true;
    consumptionDir = "/srv/ftp/scanner/";
    settings = {
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
    };
  };
}
