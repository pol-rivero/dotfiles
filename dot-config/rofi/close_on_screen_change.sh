#!/bin/sh

close_rofi() {
  killall -q rofi
}

handle() {
  case $1 in
    focusedmon*) close_rofi ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
