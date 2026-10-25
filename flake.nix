{
  description = "Minimal NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    flake-parts.url = "github:hercules-ci/flake-parts";
    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs.flake-parts.follows = "flake-parts";
    };
    import-tree.url = "github:vic/import-tree";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";

    stylix.url = "github:danth/stylix";

    # privacy settings preset for firefox
    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dwm-custom = {
      url = "github:Ladislaus-Postumus/dwm-custom";
      flake = false;
    };
    dwmblocks-custom = {
      url = "github:Ladislaus-Postumus/dwmblocks-custom";
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

  outputs = inputs @ {
    nixpkgs,
    #nixpkgs-stable,
    flake-parts,
    ez-configs,
    import-tree,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ez-configs.flakeModule
        flake-parts.flakeModules.modules
        (import-tree ./modules)
      ];
      ezConfigs.root = ./.;
      ezConfigs.globalArgs = {inherit inputs;};
      systems = ["x86_64-linux"];
    };
}
