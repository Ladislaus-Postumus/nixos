{pkgs, ...}: let
  vimSpellDe = pkgs.runCommand "vim-spell-de" {} ''
    mkdir -p $out/share/vim/vimfiles/spell
    cp ${
      pkgs.fetchurl {
        url = "https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl";
        hash = "sha256-c8cQfqM5hWzb6SHeuSpFk5xN5uucByYdobndGfaDo9E=";
      }
    } $out/share/vim/vimfiles/spell/de.utf-8.spl
    cp ${
      pkgs.fetchurl {
        url = "https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.sug";
        hash = "sha256-E9Ds+Shj2J72DNSopesqWhOg6Pm6jRxqvkerqFcUqUg=";
      }
    } $out/share/vim/vimfiles/spell/de.utf-8.sug
  '';
in {
  spellcheck = {
    enable = true;
    languages = [
      "en"
      "de"
    ];
  };

  additionalRuntimePaths = [
    "${vimSpellDe}/share/vim/vimfiles"
  ];
}
