{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-color-emoji
      ubuntu-sans
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = ["Ubuntu Sans" "Symbols Nerd Font"];
        monospace = ["JetBrainsMono Nerd Font" "Ubuntu Mono"];
      };
    };
  };
}
