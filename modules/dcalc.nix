{...}: {
  flake.modules.nixos.dcalc = {pkgs, ...}: let
    dcalc = pkgs.writeShellApplication {
      name = "dcalc";
      runtimeInputs = with pkgs; [dmenu bc gawk gnused coreutils xclip];
      text = builtins.readFile ./dcalc.sh;
    };
  in {
    environment.systemPackages = [
      dcalc
    ];
  };
}
