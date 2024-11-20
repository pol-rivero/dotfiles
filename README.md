# Dotfiles

This repository contains my personal dotfiles. Feel free to use them as a reference or copy them.

If you are not me, you (hopefully) won't have access to the `dotfiles.key` file required to decrypt some sensitive files. You can still browse the repository and use the public files you find useful.

## Installation

1. Clone the repository and apply the dotfiles:

```bash
yay -S git git-crypt stow metapac
git clone https://github.com/pol-rivero/dotfiles ~/.local/share/dotfiles
cd ~/.local/share/dotfiles
git-crypt unlock /path/to/dotfiles.key  # If you have the key
stow --dotfiles -t ~ .
```

2. Install packages:

```bash
metapac sync
```

To list the untracked packages:

```bash
metapac unmanaged
```

3. Start services:

```bash
systemctl enable --now ufw.service      # Firewall
systemctl enable --now ydotool.service  # Allow pasting from copyq and rofimoji
systemctl enable --now cronie.service   # Cron jobs
```

4. [Manually apply other configurations](manual-config/README.md)

## Usage

```bash
dotfiles-apply   # Update symlinks
dotfiles-remove  # Remove symlinks
```

## References

https://youtu.be/y6XCebnB9gs

https://www.agwa.name/projects/git-crypt

