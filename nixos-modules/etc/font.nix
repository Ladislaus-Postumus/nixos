{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
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
