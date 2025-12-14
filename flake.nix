{
  description = "Minimal NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs.flake-parts.follows = "flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
    nixvirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ez-configs,
    nvf,
    nixvirt,
    home-manager,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ez-configs.flakeModule
      ];
      ezConfigs.root = ./.;
      ezConfigs.globalArgs = {inherit inputs;};
      systems = ["x86_64-linux"];
    };
}
