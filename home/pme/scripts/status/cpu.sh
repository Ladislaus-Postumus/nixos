#!/usr/bin/env bash

COL_GOOD=$(xrdb -query | grep 'color2:' | awk '{print $2}')
COL_WARN=$(xrdb -query | grep 'color3:' | awk '{print $2}')
COL_CRIT=$(xrdb -query | grep 'color1:' | awk '{print $2}')
COL_NONE=$(xrdb -query | grep 'color0:' | awk '{print $2}')

cpu_idle=$(top -bn1 | rg "Cpu" | awk 'BEGIN { FPAT = "[0-9,.]{2,}" } { print $4 }' | awk '{print int($1)}')
cpu_usage=$((100 - cpu_idle))

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

echo -e "$(get_status "$cpu_usage") ${cpu_usage}%^d^"
