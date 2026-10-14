{
  lib,
  inputs,
  ...
}: {
  my.users.pme.enable = true;

  imports = [
    ./hardware.nix
  ];

  networking.hostName = "raspi";
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "aarch64-linux";

  #virtualisation.docker.enable = true;
  #virtualisation.docker.enableOnBoot = false;
  #systemd.services.NetworkManager-wait-online.enable = false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.pme.openssh.authorizedKeys.keys = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMQlvhjOUVM3SKyRtnsoR/iq549UchmE3MdvpPpS7mFlAAAABHNzaDo= ssh:"
  ];

  networking.firewall.allowedTCPPorts = [22];
}
