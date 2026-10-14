{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.programming.enable = mkEnableOption "apps needed for programming";

  config = mkIf config.my.features.programming.enable {
    environment.systemPackages = with pkgs; [
      devcontainer
      just
      godot
      claude-agent-acp
      claude-code
    ];
  };
}
