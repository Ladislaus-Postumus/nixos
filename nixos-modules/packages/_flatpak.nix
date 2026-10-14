{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.flatpak.nixosModules.nix-flatpak];

  services.flatpak = {
    enable = true;

    # Automatically add Flathub if not specified
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      "com.bitwarden.desktop"
    ];

    # Perform updates during nixos-rebuild / home-manager switch
    update.onActivation = true;
  };
}
