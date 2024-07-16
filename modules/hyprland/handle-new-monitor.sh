#!/usr/bin/env bash

monitoradded() {
  echo "monitor added"
}

handle() {
  case $1 in
    monitoradded*)
      pkill ags; ags & disown
      seq 2 9 | xargs -I {} hyprctl dispatch moveworkspacetomonitor {} 1
      ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
