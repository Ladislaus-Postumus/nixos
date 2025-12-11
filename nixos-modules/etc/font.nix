{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = ["Ubuntu"];
        monospace = ["JetBrainsMono Nerd Font" "Ubuntu Mono"];
      };
    };
  };
}
