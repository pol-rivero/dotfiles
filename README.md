# Dotfiles

This repository contains my personal dotfiles. Feel free to use them as a reference or copy them.

If you are not me, you (hopefully) won't have access to the `dotfiles.key` file required to decrypt some sensitive files. You can still browse the repository and use the public files you find useful.

## Installation

1. Install `yay` if needed.

   ```bash
   sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
   ```

1. Clone the repository and apply the dotfiles:

    ```bash
    yay -S git git-crypt rcm metapac
    git clone https://github.com/pol-rivero/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    git-crypt unlock /path/to/dotfiles.key  # If you have the key
    RCRC=$HOME/.dotfiles/rcrc rcup
    ```

    You should reboot before continuing with the next step.

1. Install packages:

    ```bash
    metapac sync
    ```

    To list the untracked packages:

    ```bash
    metapac unmanaged
    ```

1. Start services:

    ```bash
    systemctl enable --now ufw.service      # Firewall
    systemctl enable --now cronie.service   # Cron jobs
    systemctl enable --now cups.service     # Printing
    systemctl --user enable --now ydotool.service  # Allow pasting from copyq and rofimoji
    ```

1. Install OMZ:

    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

    - This will also prompt you to change the shell to zsh.

1. Apply dconf settings:

    ```bash
    cat ~/.config/dconf/user.plain | dconf load /
    ```

1. [Manually apply optional configurations](manual-config/README.md)

## RCM usage

- [Create/update symlinks](http://thoughtbot.github.io/rcm/rcup.1.html): `rcup`
- [Remove symlinks](http://thoughtbot.github.io/rcm/rcdn.1.html): `rcdn`
- [Add unmanaged file to dotfiles](http://thoughtbot.github.io/rcm/mkrc.1.html): `mkrc <file>`
- [List existing symlinks](http://thoughtbot.github.io/rcm/lsrc.1.html): `lsrc`


## References

- [RCM documentation](http://thoughtbot.github.io/rcm/)

- [Git-crypt project page](https://www.agwa.name/projects/git-crypt)

