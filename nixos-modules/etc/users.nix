{...}: {
  users.users.pme = {
    isNormalUser = true;
    description = "Philipp Melzer";
    extraGroups = ["networkmanager" "wheel" "video" "libvirt" "kvm" "vboxusers" "libvirtd" "plugdev" "docker"];
  };

  home-manager.users.pme = import ../../home/pme;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  users.groups.plugdev = {};
  users.groups.docker = {};
}
