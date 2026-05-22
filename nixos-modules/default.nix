{...}: {
  imports = [
    ./compositor/dwm.nix
    ./compositor/gnome.nix
    ./compositor/hyprland.nix
    ./etc/default_settings.nix
    ./etc/ai.nix
    ./etc/disks.nix
    ./etc/font.nix
    ./etc/git.nix
    ./etc/grub.nix
    ./etc/home.nix
    ./etc/keyboard.nix
    ./etc/nh.nix
    ./etc/pipewire.nix
    ./etc/users.nix
    ./packages/astro.nix
    ./packages/defaults.nix
    ./packages/gaming.nix

    ./etc/ftp.nix
    ./etc/paperless.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];
}
