#!/bin/bash

script_dir=$(dirname $0)

# Store cursor position
cursor_position=$(hyprctl cursorpos)
x=$(echo $cursor_position | cut -d ',' -f 1)
y=$(echo $cursor_position | cut -d ',' -f 2)

grim -t ppm - | satty --filename - --initial-tool crop --output-filename $HOME/Desktop/screenshot-$(date '+%Y%m%d-%H:%M:%S').png --copy-command $script_dir/screenshot-end.sh &

# Might need to adjust this value depending on the system
sleep 0.4

hyprctl dispatch movecursor $x $y
