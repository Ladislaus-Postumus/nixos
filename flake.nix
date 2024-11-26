{
  description = "1st flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/private_wsl/configuration.nix
        nixos-wsl.nixosModules.wsl
        home-manager.nixosModules.home-manager
        {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.nixos = import ./home.nix;
        system.stateVersion = "24.11";

        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
        }
      ];
    };
    nixosConfigurations.work = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/work/configuration.nix
        nixos-wsl.nixosModules.wsl
        home-manager.nixosModules.home-manager
        {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.nixos = import ./home.nix;
        system.stateVersion = "24.11";

        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
        }
      ];
    };
  };
}
