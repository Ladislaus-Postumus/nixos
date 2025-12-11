{...}: {
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    extraEntries = ''
      menuentry "Gaming Linux" {
        insmod btrfs
        set root=(hd2,2)
        linux /@/boot/vmlinuz-linux-zen root=UUID=3da8ebd8-337c-4c70-a8bb-19ba66938f1d rootflags=subvol=@ rw
        initrd /@/boot/initramfs-linux-zen.img
      }
    '';
  };
}
