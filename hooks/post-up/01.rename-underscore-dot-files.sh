#!/bin/bash

# Rename symbolic from _.* to .* to work around RCM limitations

find $HOME -maxdepth 15 -type l -name '_.*' | while read link; do
  target=$(readlink "$link")
  [[ "$target" == $HOME/.dotfiles* ]] && mv "$link" "${link/_./.}"
done


find $HOME -depth -maxdepth 15 -type d -name '_.*' -not -path "$HOME/.dotfiles/*" | while read dir; do
  new_dir="${dir%/*}/${dir##*/_}"

  if [ -d "$new_dir" ]; then
    # Merge into directory https://unix.stackexchange.com/a/127713
    rsync -a --remove-source-files "$dir/" "$new_dir/"
    find "$dir" -depth -type d -exec rmdir {} +
  else
    mv "$dir" "$new_dir"
  fi
done
