{inputs, ...}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    backupFileExtension = "bak";

    extraSpecialArgs = {
      inherit inputs;
    };

  users.pme = import ../../home/pme;
  };
}
