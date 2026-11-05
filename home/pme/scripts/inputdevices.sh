#!/usr/bin/env bash

# 1. Fetch active audio devices and clean up the tree lines
#devices=$(wpctl status | grep '\[vol:' | sed 's/^[│ ]*//')
devices=$(wpctl status | awk '
  /Sinks:/ { type = "OUT" }
  /Sources:/ { type = "IN " }
  /\[vol:/ {
    # 1. Check if this is the default device
    def = (index($0, "*") > 0) ? "*" : " "

    # 2. Clean up leading tree structural lines
    gsub(/^[│ ├─*[:space:]]+/, "")

    # 3. Extract the numeric ID
    split($0, a, "[.]")
    id = a[1]

    # 4. Isolate the device name and volume string
    rest = substr($0, index($0, ".") + 1)
    gsub(/^[[:space:]]+/, "", rest)
    v_idx = index(rest, "[vol:")
    name = substr(rest, 1, v_idx - 1)
    gsub(/[[:space:]]+$/, "", name) # clean trailing space

    # 5. Extract and convert volume to percentage
    v_part = substr(rest, v_idx)
    gsub(/[^0-9.]/, "", v_part)
    vol = v_part * 100

    # 6. Check if muted
    mute = (index(rest, "MUTED") > 0) ? " [MUTED]" : ""

    # Output cleanly padded columns for dmenu layout
    printf "%-3s │ %s [%s] │ %s (%d%%)%s\n", id, type, def, name, vol, mute
  }
')

# 2. Feed the list into dmenu
selected=$(echo "$devices" | dmenu -i -l 10 -p "Audio Devices:")

# Exit if nothing was selected (e.g., pressed Escape)
[ -z "$selected" ] && exit 0

# 3. Extract the numeric ID safely from the selection
# Splits at the first period and grabs the digits
id=$(echo "$selected" | awk -F'.' '{print $1}' | grep -oE '[0-9]+')

# 4. Prompt for the action to take on that specific device
action=$(echo -e "Toggle Mute\nSet as Default\nVolume +5%\nVolume -5%" | dmenu -i -p "Action (ID $id):")

# 5. Execute the corresponding wpctl command
case "$action" in
"Toggle Mute") wpctl set-mute "$id" toggle ;;
"Set as Default") wpctl set-default "$id" ;;
"Volume +5%") wpctl set-volume "$id" 5%+ ;;
"Volume -5%") wpctl set-volume "$id" 5%- ;;
esac
