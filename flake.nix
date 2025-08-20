{
  description = "Minimal NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";

    #nixvim = {
    #  url = "github:nix-community/nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = {
    self,
    nixpkgs,
    #nixvim,
    nvf,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    # Define the NixOS system configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        nvf.nixosModules.default
        ./hardware-configuration.nix # reference to the generated hardware config
        ({
          config,
          pkgs,
          lib,
          ...
        }: {
          system.stateVersion = "24.11"; # Did you read the comment?
          nix.settings.experimental-features = ["nix-command" "flakes"];

          # Bootloader.
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

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

          # Enable networking
          networking.networkmanager.enable = true;

          # 1. Hostname and user setup
          networking.hostName = "nixos";
          users.users.pme = {
            isNormalUser = true;
            home = "/home/pme";
            description = "pme";
            extraGroups = ["wheel" "networkmanager"];
            shell = pkgs.zsh;
          };
          users.users.greeter = {
            isSystemUser = true;
            description = "greetd user";
            createHome = false;
            extraGroups = [ "video" "input" "render" ];
            shell = "/usr/sbin/nologin";
          };

          # 2. System packages (systemwide)
          #    We install Firefox, Kitty, Git, Neovim, Zsh, Hyprland, and Nix dev tools.
          environment.systemPackages = with pkgs; [
            firefox # default browser
            kitty # terminal emulator
            git # version control
            neovim # editor
            zsh # shell
            zsh-powerlevel10k
            hyprland # Wayland compositor
            nh # NixOS helper (rebuild with diffs):contentReference[oaicite:0]{index=0}
            nix-output-monitor
            nvd # Nix version diff tool:contentReference[oaicite:1]{index=1}
            alejandra # Nix code formatter (for nixvim)
            nixd # Nix language server (LSP)
            statix # Nix linter (optional)
            cage
            greetd
            regreet
            keepassxc
            wofi
          ];

          # 3. Default applications (set via environment variables)
          environment.variables = {
            EDITOR = "nvim"; # make Neovim the default editor
            BROWSER = "firefox"; # default browser
            TERMINAL = "kitty"; # default terminal emulator
            SHELL = "zsh";
          };

          programs.regreet.enable = true;
          services.greetd = {
            enable = true;
            settings = {
              terminal = { vt = 1; };
              default_session = {
                command = "${pkgs.cage}/bin/cage -s -- ${pkgs.regreet}/bin/regreet";
                user = "greeter";
              };
            };
          };

          programs.uwsm.enable = true;
          programs.hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
          };
          services.desktopManager.plasma6.enable = true;

          # Git user config (per-user)
          programs.git = {
            enable = true;
            # config = [
            #   {
            #     user.name = "Philipp Melzer";
            #     user.email = "philipp.melzer2014@gmail.com";
            #   }
            # ];
          };

          # Zsh, Oh My Zsh and Powerlevel10k theme (per-user)
          programs.zsh.enable = true;
          programs.zsh.oh-my-zsh.enable = true;
          #programs.zsh.oh-my-zsh.theme = pkgs.powerlevel10k;

          programs.nvf = {
            enable = true;
            settings = {
              vim.lsp = {
                enable = true;
              };
              vim.languages = {
                nix.enable = true;
              };
            };
          };

        })
      ];
    };
  };
}
