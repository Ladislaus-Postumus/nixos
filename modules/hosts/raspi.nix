{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.raspi = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;}; # bridge: old modules expect `inputs`
    modules = with config.flake.modules.nixos; [
      ../../nixos-modules # bridge: my.users.*, core.nix, default_settings, ...
      raspi
      ssh-server
      blocky
    ];
  };

  flake.modules.nixos.raspi = {modulesPath, ...}: {
    imports = [(modulesPath + "/installer/sd-card/sd-image-aarch64.nix")];

    nixpkgs.hostPlatform = "aarch64-linux";
    networking.hostName = "raspi";
    system.stateVersion = "26.11";

    my.users.pme.enable = true;
    my.home.pme.enable = false;

    security.sudo.wheelNeedsPassword = false;
    nix.settings.trusted-users = ["@wheel"];

    hardware.enableRedistributableFirmware = true;
    networking.wireless = {
      enable = true;
      secretsFile = "/var/lib/secrets/wifi.env";
      networks."TeeLan".pskRaw = "ext:home_psk";
    };

    users.users.pme.openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNr... ssh:"
    ];
  };
}
