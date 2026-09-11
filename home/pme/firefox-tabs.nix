{
  pkgs,
  lib,
  ...
}: let
  sessionData = {
    windows = [
      {
        groups = [
          {
            id = "stream";
            name = "Streaming";
            color = "red";
          }
        ];
        tabs = [
          {
            entries = [{url = "https://xing.com";}];
          }
          {
            entries = [{url = "https://mail.proton.me";}];
            pinned = true;
          }

          {
            entries = [{url = "https://youtube.com";}];
            groupId = "stream";
          }
          {
            entries = [{url = "https://fmhy.net/video";}];
            groupId = "stream";
          }
          {
            entries = [{url = "https://bbc.co.uk/iplayer";}];
            groupId = "stream";
          }
          {
            entries = [{url = "https://twitch.tv";}];
            groupId = "stream";
          }
          #{
          #  entries = [{url = "https://kagi.com";}];
          #  pinned = false;
          #}
        ];
        selected = 3;
      }

      {
        groups = [
          {
            id = "work";
            name = "Work";
            color = "blue";
            collapsed = true;
          }
          {
            id = "ai";
            name = "ai";
            color = "purple";
            collapsed = true;
          }
        ];
        tabs = [
          {
            entries = [{url = "https://claude.ai";}];
            groupId = "ai";
          }
          {
            entries = [{url = "https://gemini.google.com";}];
            groupId = "ai";
          }
          {
            entries = [{url = "https://chatgpt.com";}];
            groupId = "ai";
          }
          {
            entries = [{url = "https://github.com/ladislaus-postumus";}];
            groupId = "work";
          }
        ];
        selected = 1;
      }
    ];
  };

  compiledSessionStore =
    pkgs.runCommand "sessionstore.jsonlz4" {
      nativeBuildInputs = [pkgs.python3Packages.lz4];
      jsonString = builtins.toJSON sessionData;
    } ''
      python3 -c '
      import os, sys, lz4.block

      data = os.environ["jsonString"].encode("utf-8")
      header = b"mozLz40\x00" + len(data).to_bytes(4, byteorder="little")
      compressed = lz4.block.compress(data, store_size=False)

      with open(sys.argv[1], "wb") as f:
          f.write(header + compressed)
      ' "$out"
    '';

  # Pre-launch hook to restore session files before Firefox executes
  resetSessionScript = ''
    PROFILE_DIR="$HOME/.config/mozilla/firefox/default"
    mkdir -p "$PROFILE_DIR/sessionstore-backups"
    cp -f "${compiledSessionStore}" "$PROFILE_DIR/sessionstore.jsonlz4"
    cp -f "${compiledSessionStore}" "$PROFILE_DIR/sessionstore-backups/recovery.jsonlz4"
    cp -f "${compiledSessionStore}" "$PROFILE_DIR/sessionstore-backups/recovery.baklz4"
    rm -f "$PROFILE_DIR/sessionstore-backups/previous.jsonlz4"
  '';

  # Wrapper function to add the pre-launch hook
  wrapWithReset = pkg:
    pkgs.symlinkJoin {
      name = "firefox-deterministic";
      paths = [pkg];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/firefox \
          --run '${resetSessionScript}'
      '';
    };

  origOverride = pkgs.firefox.override;
  overrideFn = args: wrapWithReset (origOverride args);
in {
  programs.firefox = {
    enable = true;

    # Wrap the Firefox binary while preserving Home Manager's override interface
    package =
      wrapWithReset pkgs.firefox
      // {
        override = lib.setFunctionArgs overrideFn (lib.functionArgs origOverride);
      };

    profiles.default.settings = {
      "browser.startup.page" = 3;
    };
  };
}
