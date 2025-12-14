{inputs, ...}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useGlobalPkgs = true;
    useUserPkgs = true;
    backupFileExtension = "bak";
  };
}
