# shellcheck shell=bash
# Usage: dmenu-gitmoji      copies the emoji
#        dmenu-gitmoji -c   copies the shortcode

copy() {
  printf '%s' "$out" | xclip -sel clip
  notify-send "Copied $out" || true
}

choice=$(jq -r '.gitmojis[]
  | "\(.emoji) \(.code)\(" " * ([32 - (.code | length), 1] | max))\(.description)"' "$GITMOJIS" |
  dmenu -i -l 20 -p gitmoji) || exit 1

if [ "${1:-}" = "-c" ]; then
  out=$(printf '%s\n' "$choice" | awk '{print $2}')
else
  out=$(printf '%s\n' "$choice" | awk '{print $1}')
fi
copy
