# Dotfiles

## Installation

```bash
yay -S git git-crypt stow
git clone https://github.com/p-rivero/dotfiles ~/.local/share/dotfiles
cd ~/.local/share/dotfiles
git-crypt unlock /path/to/dotfiles.key
stow --dotfiles -t ~ .
```

Start services:

```bash
systemctl enable --now ufw.service # Firewall
systemctl enable --now ydotool.service # To allow pasting from copyq and rofimoji
```

## Usage

```bash
dotfiles-apply   # Update symlinks
dotfiles-remove  # Remove symlinks
```

## References

https://youtu.be/y6XCebnB9gs

https://www.agwa.name/projects/git-crypt

