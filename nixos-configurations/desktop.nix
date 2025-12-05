{ pkgs, ... }:
{
  ##############################
  ### System Packages ##########
  ##############################

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    firefox
    kitty
    keepassxc
    wl-clipboard
    keymapp
    fzf
    bat
    eza
    starship
    yazi
    asciiquarium
    cowsay
    lazygit

    virt-manager
    virt-viewer
    swtpm

    exiftool
    zip
    unzip
    discord
    syncthing

    heroic
    prismlauncher

    mpv
    feh
    gimp3

    siril
  ];

  imports = [ ./desktop-hardware.nix ../nixos-modules/winboat.nix ];
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Ubuntu"];
        monospace = [ "JetBrainsMono Nerd Font" "Ubuntu Mono"];
      };
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 14d --keep 5";
    flake = "/home/pme/nix-config#nixosConfigurations.desktop";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.git = {
    enable = true;
    config = [
      {
        user = {
          name = "Philipp Melzer";
          email = "philipp.melzer2014@gmail.com";
        };
      }
      { init = {
        defaultBranch = "main";
      };}
    ];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="1977", MODE="0660", GROUP="plugdev"
  '';

  ##############################
  ### Users ####################
  ##############################

  users.users.pme = {
    isNormalUser = true;
    description = "Philipp Melzer";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirt" "kvm" "vboxusers" "libvirtd" "plugdev" ];
    packages = with pkgs; [
      #omnissa-horizon-client
    ];
  };


  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  users.groups.plugdev = {};

  ##############################
  ### Gnome ####################
  ##############################

  # Enable the GNOME Desktop Environment.
   services.displayManager.gdm.enable = true;
   services.desktopManager.gnome.enable = true;

  services.gnome = {
    #core-apps.enable = false;
    games.enable = false;
  };
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  ##############################
  ### Anderer Bums #############
  ##############################

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Bootloader.
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

  networking.hostName = "desktop";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  programs.corectrl.enable = true;
}
