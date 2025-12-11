{...}: {
  users.users.pme = {
    isNormalUser = true;
    description = "Philipp Melzer";
    extraGroups = ["networkmanager" "wheel" "video" "libvirt" "kvm" "vboxusers" "libvirtd" "plugdev" "docker"];
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  users.groups.plugdev = {};
  users.groups.docker = {};
}
