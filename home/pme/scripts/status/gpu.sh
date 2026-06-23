#!/usr/bin/env bash

COL_GOOD=$(xrdb -query | grep 'color2:' | awk '{print $2}')
COL_WARN=$(xrdb -query | grep 'color3:' | awk '{print $2}')
COL_CRIT=$(xrdb -query | grep 'color1:' | awk '{print $2}')
COL_NONE=$(xrdb -query | grep 'color0:' | awk '{print $2}')

gpu_path="/sys/class/drm/card1/device/gpu_busy_percent"
if [[ -f "$gpu_path" ]]; then
  gpu_usage=$(cat "$gpu_path" | tr -d '\0')
else
  gpu_usage=0
fi

# --- Helper Function for Coloring ---
# Syntax: get_icon [value] [icon_low] [icon_high]
get_status() {
  local val=$1
  if (( val > 85 )); then
    echo "^b$COL_CRIT^^c$COL_NONE^"
  elif (( val > 70 )); then
    echo "^b$COL_WARN^^c$COL_NONE^"
  elif (( val > 50 )); then
    echo "^b$COL_GOOD^^c$COL_NONE^"
  else
    echo "^d^"
  fi
}

echo -e "$(get_status "$gpu_usage")󰢮 ${gpu_usage}%^d^"
