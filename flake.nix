{
  description = "Minimal NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    # Define the NixOS system configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hardware-configuration.nix # reference to the generated hardware config
        ({
          config,
          pkgs,
          lib,
          ...
        }: {
          imports = [home-manager.nixosModules.home-manager];

          # Bootloader.
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

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

          # 1. Hostname and user setup
          networking.hostName = "nixos";
          users.users.pme = {
            isNormalUser = true;
            home = "/home/pme";
            description = "pme";
            extraGroups = ["wheel" "networkmanager"];
            #shell        = pkgs.zsh;
          };

          # 2. System packages (systemwide)
          #    We install Firefox, Kitty, Git, Neovim, Zsh, Hyprland, and Nix dev tools.
          environment.systemPackages = with pkgs; [
            firefox # default browser
            kitty # terminal emulator
            git # version control
            neovim # editor
            zsh # shell
            hyprland # Wayland compositor
            nh # NixOS helper (rebuild with diffs):contentReference[oaicite:0]{index=0}
            nix-output-monitor
            nvd # Nix version diff tool:contentReference[oaicite:1]{index=1}
            alejandra # Nix code formatter (for nixvim)
            nixd # Nix language server (LSP)
            statix # Nix linter (optional)
          ];

          # 3. Default applications (set via environment variables)
          environment.variables = {
            EDITOR = "nvim"; # make Neovim the default editor
            BROWSER = "firefox"; # default browser
            TERMINAL = "kitty"; # default terminal emulator
            SHELL = "zsh";
          };

          # 4. Services
          #    Enable greetd as a login manager (for Wayland/graphical login)
          services.greetd.enable = true;
          services.greetd.settings = {
            default_session.command = "${pkgs.hyprland}/bin/hyprland";
            default_session.user = "pme";
          };
          # Hyprland has no dedicated NixOS module, but we install it and run via greetd.

          # 5. Enable Home Manager for user-specific config
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = false;
          home-manager.users.pme = {
            home.stateVersion = "24.11";
            imports = [
              nixvim.homeManagerModules.nixvim
            ];

            # Git user config (per-user)
            programs.git.enable = true;
            programs.git.userName = "Your Name";
            programs.git.userEmail = "you@example.com";

            # Zsh, Oh My Zsh and Powerlevel10k theme (per-user)
            programs.zsh.enable = true;
            programs.zsh.oh-my-zsh.enable = true;
            programs.zsh.oh-my-zsh.theme = "powerlevel10k/powerlevel10k";
            # programs.zsh.defaultShell   = true;

            # Kitty terminal (per-user)
            programs.kitty.enable = true;

            # NixVim configuration (per-user)
            programs.nixvim = {
              enable = true;
              colorscheme = "desert";
              opts = {
                number = true;
              };

              plugins = {
                nix.enable = true;
                lsp.enable = true;
                conform-nvim = {
                  enable = true;
                  settings = {
                    formatters_by_ft = {
                      nix = ["alejandra"];
                    };
                    format_on_save =
                      # Lua
                      ''
                        function(bufnr)
                          local slow_format_filetypes = slow_format_filetypes or {}

                          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                            return
                          end

                          if slow_format_filetypes[vim.bo[bufnr].filetype] then
                            return
                          end

                          local function on_format(err)
                            if err and err:match("timeout$") then
                              slow_format_filetypes[vim.bo[bufnr].filetype] = true
                            end
                          end

                          return { timeout_ms = 200, lsp_fallback = true }, on_format
                         end
                      '';
                    formatters = {
                      alejandra.command = lib.getExe pkgs.alejandra;
                    };
                  };
                };
              };
            };
          };
        })
      ];
    };
  };
}
