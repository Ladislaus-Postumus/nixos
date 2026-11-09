{inputs, ...}: {
  flake.modules.nixos.emoji-picker = {pkgs, ...}: let
    gitmojis = "${inputs.gitmoji}/packages/gitmojis/src/gitmojis.json";
    gemoji = "${inputs.gemoji}/db/emoji.json";

    runtimeInputs = with pkgs; [dmenu jq xclip gawk libnotify];

    copy = ''
      printf '%s' "$out" | xclip -sel clip
      notify-send "Copied $out" || true
    '';

    dmenu-gitmoji = pkgs.writeShellApplication {
      name = "dmenu-gitmoji";
      text = ''
        # Usage: dmenu-gitmoji      copies the emoji
        #        dmenu-gitmoji -c   copies the shortcode
        choice=$(jq -r '.gitmojis[]
          | "\(.emoji) \(.code)\(" " * ([32 - (.code | length), 1] | max))\(.description)"' \
        ${gitmojis} \
        | dmenu -i -l 20 -p gitmoji) || exit 1

        if [ "''${1:-}" = "-c" ]; then
          out=$(printf '%s\n' "$choice" | awk '{print $2}')
        else
          out=$(printf '%s\n' "$choice" | awk '{print $1}')
        fi
        ${copy}
      '';
    };
  in {
    environment.systemPackages = [
      dmenu-gitmoji
      #dmenu-emoji
    ];
  };
}
