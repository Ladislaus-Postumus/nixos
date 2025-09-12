{nixvirt}: {
  virtualisation.libvirt = {
    enable = true;
    swtpm.enable = true;
    connections."qemu:///session".domains = [
      {
        definition = nixvirt.lib.domain.writeXml (nixvirt.lib.domain.template.windows
          {
            name="win10";
          });
      }
    ];
  };
};
