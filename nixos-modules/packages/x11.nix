{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.features.x11.enable = mkEnableOption "apps only for x11 systems";

  config = mkIf config.my.features.x11.enable {
    environment.systemPackages = with pkgs; [
      flameshot
      gammastep
      haskellPackages.greenclip
      maim # screenshots
      picom # compositor adding fancy effects (shadows, transparency, vsync, ...)
      setxkbmap # allows keyboard layout changes
      xclip
      xdotool # keyboard simulator (autohotkey)
      xfce4-power-manager # battery manager, handles suspend (ie if video playing) on non desktop environments (dwm)
      xinit
    ];

    services.espanso.enable = true;
  };
}
