# Full Minimal NixOs Configuration
This repo will contain a full minimal example of NixOs whil utilizing flakes and home-manager.

This readme will evolve along the repo and explain the steps between commits and why they were taken.

Major progress will be documented using git tags.

## NixOs
In order to get a minimal NixOs one first has to install it either
* via [GUI Installer]()
* or [manually]()

This will create a basic working NixOs setup, whose config can be found under `/etc/nixos`.
The `hardware-configuration.nix` contains hardware-specific settings and will most likely never be touched.
The `configuration.nix` on the other hand currently contains both system and user configuration.
Editing this file requires elevated privileges.
Next additional packages like git and an editor have to be installed.
This is done by adding them to the `environment.systemPackages` entry.

This guide will continue using flakes, the following line, added anywhere in the configuration, will enable this feature `nix.settings.experimental-features = [ "nix-command" "flakes" ];`.


Once the changes have been saved, the the system can be rebuilt and the changes applied using:
```
sudo nixos-rebuild switch
```

## Flakes
While flakes are still considered experimental in official documents, they are widely adopted and considered best practice in the Nix community.
Flakes greatly improve the reproducability, reliability and organiziation of a Nix configuration.
After running:
```
git init nix-config && cd nix-config
nix flake init
```
A new git repository will contain a `flake.nix` file.
This file is created using the flake default template.

The default flake setup contains three sections:
* `description` may contain any text and is not relevant for now
* `inputs` declares, which nix modules are to be imported, for now it only contains the nixpkgs channel
* `ouputs` declares, well, the outputs of the flake, in our case we want to output a nixosConfiguration

To convert the existing Nix configuration to a flake-based one without too much effort, the generated outputs section was replaced with a simple `nixosConfiguration` block that imports the existing `configuration.nix` as a module.
This allows the system to be built using flakes, without changing the current configuration.
