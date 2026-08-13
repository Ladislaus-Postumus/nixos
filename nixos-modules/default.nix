{...}: {
  imports = [
    ./compositor/dwm.nix
    ./compositor/gnome.nix

    ./etc/default_settings.nix
    ./etc/disks.nix
    ./etc/font.nix
    ./etc/ftp.nix
    ./etc/git.nix
    ./etc/grub.nix
    ./etc/home.nix
    ./etc/keyboard.nix
    ./etc/nh.nix
    ./etc/paperless.nix
    ./etc/pipewire.nix

    ./packages/astro.nix
    ./packages/defaults.nix
    ./packages/flatpak.nix
    ./packages/gaming.nix

    ./users/groups.nix
    ./users/pme.nix
    ./users/tech.nix
    ./users/victor.nix
  ];

  nixpkgs.config.permittedInsecurePackages = ["openssl-1.1.1w"];
}
