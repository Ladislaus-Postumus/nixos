{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = ["Ubuntu Sans"];
        monospace = ["JetBrainsMono Nerd Font" "Ubuntu Mono"];
      };
    };
  };
}
