{
  config,
  pkgs,
  ...
}: {
  my.users.pme.enable = true;
  my.home.pme.enable = false;

  imports = [
    ./hardware.nix
  ];

  networking.hostName = "raspi";
  system.stateVersion = "26.11";
  nixpkgs.hostPlatform = "aarch64-linux";

  # sudo doesn't need password, since pi is connected with ssh via fido key should be fine
  security.sudo.wheelNeedsPassword = false;

  # wifi
  hardware.enableRedistributableFirmware = true;
  networking = {
    wireless = {
      enable = true;
      secretsFile = "/var/lib/secrets/wifi.env";
      networks."TeeLan".pskRaw = "ext:home_psk";
    };

    interfaces.wlan0.ipv6.addresses = [
      {
        address = "fd19:256c:77ce::68";
        prefixLength = 64;
      }
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  nix.settings.trusted-users = ["@wheel"];
  users.users.pme.openssh.authorizedKeys.keys = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMQlvhjOUVM3SKyRtnsoR/iq549UchmE3MdvpPpS7mFlAAAABHNzaDo= ssh:"
  ];

  ### BLOCKY CONFIG
  environment.systemPackages = [config.services.blocky.package config.services.prosody.package pkgs.openssl];
  services.blocky = {
    enable = true;
    settings = {
      ports = {
        dns = 53; # LAN clients
        http = "127.0.0.1:4000"; # REST API for the `blocky` CLI, local only
      };

      # Encrypted upstreams; blocky races 2 of them per query
      upstreams.groups.default = [
        "https://dns.quad9.net/dns-query" # DoH
        "https://dns.digitale-gesellschaft.ch/dns-query"
        "tcp-tls:one.one.one.one:853" # DoT
      ];

      # Plain DNS used only to resolve the hostnames above + list URLs
      bootstrapDns = ["tcp+udp:9.9.9.9" "tcp+udp:1.1.1.1"];

      blocking = {
        denylists.ads = [
          "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/pro.txt"
        ];
        allowlists.ads = [
          ''
            # inline exceptions, one domain per line
          ''
        ];
        clientGroupsBlock.default = ["ads"];
        loading.strategy = "fast"; # serve DNS immediately, lists load in background
      };

      customDNS = {
        customTTL = "1h";
        mapping = {
          "xmpp.home.arpa" = "192.168.178.68";
        };
      };

      caching = {
        minTime = "5m";
        prefetching = true;
      };

      conditional.mapping = {
        "fritz.box" = "192.168.178.1";
        "." = "192.168.178.1";
        "178.168.192.in-addr.arpa" = "192.168.178.1";
      };
      clientLookup.upstream = "192.168.178.1";

      # Every query to the journal (`journalctl -u blocky -f`) — handy while learning;
      # switch to "none" later to spare the SD card.
      queryLog.type = "console";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      #blocky
      53
      #prososdy
      5222
      5281
    ];
    allowedUDPPorts = [53];
  };

  services.prosody = {
    enable = true;
    extraConfig = ''
      certificates = "/var/lib/prosody"
    '';
    admins = ["pme@xmpp.home.arpa"];
    allowRegistration = true; #don't care on local test
    muc = [{domain = "conference.xmpp.home.arpa";}];
    httpFileShare = {domain = "uploads.xmpp.home.arpa";};
    virtualHosts = {
      test = {
        domain = "xmpp.home.arpa";
        enabled = true;
      };
    };
  };
}
