{inputs, ...}: {
  flake.modules.nixos.emoji-picker = {pkgs, ...}: let
    #gemoji = "${inputs.gemoji}/db/emoji.json";
    dmenu-gitmoji = pkgs.writeShellApplication {
      name = "dmenu-gitmoji";
      runtimeInputs = with pkgs; [dmenu jq xclip gawk libnotify];
      runtimeEnv = {
        GITMOJIS = "${inputs.gitmoji}/packages/gitmojis/src/gitmojis.json";
      };
      text = builtins.readFile ./emoji-picker.sh;
    };
  in {
    environment.systemPackages = [
      dmenu-gitmoji
      #dmenu-emoji
    ];
  };
}
