{nixvirt, system, ...}: {
  environment.systemPackages = [
    nixvirt.packages.${system}.default
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirt = {
    enable = true;
    swtpm.enable = true;

    connections."qemu:///system" = {
      domains = [
        {
          definition = nixvirt.lib.domain.writeXML (nixvirt.lib.domain.templates.windows
            {
              name = "win10";
              uuid = "879e1596-ec67-4f99-8dd0-5e2385d0154f";
              memory = { count = 6; unit = "GiB"; };
              storage_vol = { pool = "VMsPool"; volume = "win10.qcow2"; };
              install_vol = "/home/pme/VMs/win10.iso";
              nvram_path = "/home/pme/VMs/win10.fd";
              bridge_name = "virbr0";
              virtio_net = false;
              virtio_drive = false;
              install_virtio = false;
            });
          active = true;
          restart = false;
        }
      ];

      networks = [
        {
          definition = nixvirt.lib.network.writeXML (nixvirt.lib.network.templates.bridge {
            name = "default";
            uuid = "816c02d2-83de-4acc-b81a-2ff6de1feaad";
            subnet_byte = 100;
          });
          active = true;
          restart = true;
        }
      ];

      pools = [
        {
          definition = nixvirt.lib.pool.writeXML ({
            name = "VMsPool";
            uuid = "26b437e2-510f-4e5a-8ecc-3a9a41b7ffb0";
            type = "dir";
            target = { path = "/home/pme/VMs"; };
          });
          active = true;
          restart = true;
          volumes = [
            {
              definition = nixvirt.lib.volume.writeXML ({
                name = "win10.qcow2";
                capacity = { count = 30; unit = "GiB"; };
              });
            }
          ];
        }
      ];
    };
  };
}
