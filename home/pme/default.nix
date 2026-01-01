{pkgs, ...}: {
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
  ];

  #home.sessionVariables = {
  #  GIO_EXTRA_MODULES = "";
  #  GDK_PIXBUF_MODULE_FILE = "";
  #};

  programs.lutris.enable = true;
}
