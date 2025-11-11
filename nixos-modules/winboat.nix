{ config, pkgs, lib, ... }:

{
  options.winboat.enable = lib.mkEnableOption "Install Winboat AppImage with all dependencies";

  config = lib.mkIf config.winboat.enable {
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      freerdp
      docker-compose
      appimage-run

      (stdenv.mkDerivation {
        pname = "winboat";
        version = "latest";
        src = fetchurl {
          url = "https://github.com/winboat-project/winboat/releases/latest/download/Winboat-x86_64.AppImage";
          sha256 = "sha256:7c32a6b8aa0cb02d1aad609332aedd37bb34a1ad525105349477535880669fcd";
        };
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/bin
          cp $src $out/bin/winboat
          chmod +x $out/bin/winboat
        '';
      })
    ];
  };
}

