{...}: {
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
  networking.wireless = {
    enable = true;
    secretsFile = "/var/lib/secrets/wifi.env";
    networks."TeeLan".pskRaw = "ext:home_psk";
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
}
