#!/usr/bin/env bash

vol=$(pamixer --get-volume 2>/dev/null)
mute=$(pamixer --get-mute 2>/dev/null)

if (( $vol == "0" )) || [[ $mute == "true" ]]; then
  echo 󰝟 $vol%
elif (( $vol < "33" )); then
  echo 󰕿 $vol%
elif (( $vol < "66" )); then
  echo 󰖀 $vol%
else
  echo 󰕾 $vol%
fi

