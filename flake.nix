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
    vim-dadbod = {
      url = "github:tpope/vim-dadbod";
      flake = false;
    };

    vim-dadbod-ui = {
      url = "github:kristijanhusak/vim-dadbod-ui";
      flake = false;
    };

    vim-dadbod-completion = {
      url = "github:kristijanhusak/vim-dadbod-completion";
      flake = false;
    };

    nixvirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    dwm-custom = {
      url = "github:Ladislaus-Postumus/dwm-custom";
      flake = false;
    };
    st-custom = {
      url = "github:Ladislaus-Postumus/st-custom";
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
      nixvirt,
      home-manager,
      vim-dadbod,
      vim-dadbod-ui,
      vim-dadbod-completion,
      stylix,
      dwm-custom,
      st-custom,
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
