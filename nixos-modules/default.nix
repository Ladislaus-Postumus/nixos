{...}: {
  imports = [
    ./nvim.nix

    ./compositor/gnome.nix
    ./compositor/hyprland.nix
    ./etc/default_settings.nix
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
  ];
}
