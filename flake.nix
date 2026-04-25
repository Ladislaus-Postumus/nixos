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

    stylix.url = "github:danth/stylix";

    dwm-custom = {
      url = "github:Ladislaus-Postumus/dwm-custom";
      flake = false;
    };
    st-custom = {
      url = "github:Ladislaus-Postumus/st-custom";
      flake = false;
    };
    dmenu-custom = {
      url = "github:Ladislaus-Postumus/dmenu-custom";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      ez-configs,
      nvf,
      home-manager,
      stylix,
      dwm-custom,
      st-custom,
      dmenu-custom,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ez-configs.flakeModule
      ];
      ezConfigs.root = ./.;
      ezConfigs.globalArgs = { inherit inputs; };
      systems = [ "x86_64-linux" ];
    };
}
