{
  config,
  pkgs,
  lib,
  ...
}:

with pkgs;
let
  # Fetch upstream dwm
  dwmSrc = builtins.fetchGit {
    url = "git://git.suckless.org/dwm";
    ref = "6.6";
    shallow = true; # fetch just the tag, faster
  };
in
{
  # Expose a package you can use in your system
  environment.systemPackages = with pkgs; [
    (stdenv.mkDerivation rec {
      pname = "dwm-custom";
      version = "6.6";

      src = dwmSrc;

      patches = [ ./config.patch ];

      buildPhase = ''
        make
      '';
      installPhase = ''
        mkdir -p $out/bin
        cp dwm $out/bin/
      '';
    })
  ];
}
