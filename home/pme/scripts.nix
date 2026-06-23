# scripts.nix
{pkgs, ...}: {
  home.packages = [
    (pkgs.writeScriptBin "bluetooth-stat" (builtins.readFile ./scripts/status/bluetooth.sh))
    (pkgs.writeScriptBin "cpu-stat" (builtins.readFile ./scripts/status/cpu.sh))
    (pkgs.writeScriptBin "gpu-stat" (builtins.readFile ./scripts/status/gpu.sh))
    (pkgs.writeScriptBin "mem-stat" (builtins.readFile ./scripts/status/mem.sh))
    (pkgs.writeScriptBin "network-stat" (builtins.readFile ./scripts/status/network.sh))
    (pkgs.writeScriptBin "volume-stat" (builtins.readFile ./scripts/status/volume.sh))

    (pkgs.writeScriptBin "mk-rust" (builtins.readFile ./scripts/mk-rust.sh))
  ];
}
