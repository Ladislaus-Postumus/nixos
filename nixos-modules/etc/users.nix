{...}: {
  users.users.pme = {
    isNormalUser = true;
    description = "Philipp Melzer";
    extraGroups = ["networkmanager" "wheel" "video" "libvirt" "kvm" "vboxusers" "libvirtd" "plugdev" "docker"];
  };

  users.users.guest = {
    isNormalUser = true;
    description = "Guest";
    extraGroups = [];
  };

  systemd.tmpfiles.rules = [
    "d /home/guest/Steam 0755 guest guest -"
  ];

  systemd.mounts = [
    {
      name = "home-guest-Steam.mount";
      what = "/home/pme/.local/share/Steam";
      where = "/home/guest/Steam";
      type = "none";
      options = "bind, ro";
    }
  ];

  home-manager.users.pme = import ../../home/pme;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  users.groups.plugdev = {};
  users.groups.docker = {};
}
