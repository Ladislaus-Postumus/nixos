{
  description = "Minimal NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    nixvirt = {
        url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    nixvirt
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    # Define the NixOS system configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        nvf.nixosModules.default
        ./hardware-configuration.nix
        ./configuration.nix
        ./nvim.nix
        ./virt.nix
      ];
    };
  };
}
