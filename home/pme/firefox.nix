{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.arkenfox.hmModules.arkenfox
    ./firefox-tabs.nix
  ];

  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      ExtensionSettings = {
        "*".installationMode = "force_installed";
      };
      Cookies = {
        ExpireAtSessionEnd = true;
        Allow = [
          "https://proton.me"
          "https://mail.proton.me"
          "https://xing.com"

          "https://cinejoy.pk"
          "https://youtube.com"
          "https://bbc.co.uk"
          "https://amazon.de"
          "https://twitch.tv"
          "https://streamwithvpn.com"
          "https://crunchyroll.com"

          "https://claude.com"
          "https://claude.ai"
          "https://chagtpt.com"
          "https://gemini.google.com"
          "https://github.com"
          "https://bitwarden.com"

          "https://boardgamearena.com"
          "https://boardgamegeek.com"
        ];
      };
    };
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      id = 0;
      isDefault = true;
      arkenfox = {
        enable = true;
        version = "master";
        enableAllSections = true;
      };

      settings = {
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.startup.page" = 3;
        "browser.warnOnQuit" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.offlineApps" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1; # da fuq is that

        # Disable asking to save passwords
        "signon.rememberSignons" = false;
        # Disable autofill for logins, addresses, and credit cards
        "signon.autofillForms" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
      };

      containersForce = true;
      containers = {
        foo = {
          name = "foo";
          id = 1;
          color = "red";
        };
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "NixOS Search";
            url = "https://search.nixos.org";
          }
          {
            name = "Bash Wiki";
            url = "https://mywiki.wooledge.org";
          }
          {
            name = "Home-Manager Options";
            url = "https://home-manager-options.extranix.com/?query={searchTerms}";
          }
          {
            name = "Streaming";
            url = "https://streamwithvpn.com";
          }
          {
            name = "NVF Options";
            url = "https://nvf.notashelf.dev/search.html";
          }
          {
            name = "Nerd Fonts/Icons";
            url = "https://www.nerdfonts.com/cheat-sheet";
          }
          {
            name = "BGA";
            url = "https://boardgamearena.com";
          }
          {
            name = "BGG";
            url = "https://boardgamegeek.com";
          }
        ];
      };

      search = {
        force = true;
        default = "ddg";

        engines = {
          "Nix Packages" = {
            urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];
            definedAliases = ["@np"];
          };
          "Home-Manager Options" = {
            urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
            definedAliases = ["@hm"];
          };
          "Firefox Addons" = {
            urls = [{template = "https://gitlab.com/rycee/nur-expressions/-/search?search=path:pkgs/firefox-addons/addons.json+{searchTerms}&scope=blobs";}];
            definedAliases = ["@fa"];
          };
          "NVF Options" = {
            urls = [{template = "https://nvf.notashelf.dev/search.html?q={searchTerms}";}];
            definedAliases = ["@nvf"];
          };
        };
      };

      extensions = {
        force = true;
        packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          bitwarden
          darkreader
          i-dont-care-about-cookies
          tridactyl
          ublock-origin
        ];
      };

      handlers = {
        schemes.mailto = {
          action = 2;
          ask = false;
          handlers = [
            {
              name = "Proton";
              uriTemplate = "https://mail.proton.me/u/0/composer?mailto=%s";
            }
          ];
        };
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["yazi.desktop"];
    };
  };
}
