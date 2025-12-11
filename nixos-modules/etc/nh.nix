{...}: {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 14d --keep 5";
    flake = "/home/pme/nix-config#nixosConfigurations.desktop";
  };
}
