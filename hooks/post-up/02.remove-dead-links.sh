#!/bin/bash

find $HOME -depth -maxdepth 15 -type l | while read link; do
  if [ ! -e "$link" ]; then
    target=$(readlink "$link")
    [[ "$target" == $HOME/.dotfiles* ]] && rm "$link"
  fi
done
