# Manual config

This directory contains configuration files that I wasn't able to automate.  
If you don't have the `dotfiles.key` file, some files will be encrypted and most steps below probably won't be useful to you.

## Skip sudo password

1. Run `sudo visudo`
2. Add the following line at the end of the file (replace `your_username` with your username):
    ```
    your_username ALL=(ALL) NOPASSWD: ALL
    ```

## ZSH + OMZ

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- This will also prompt you to change the default shell to zsh.

## SDDM Autologin

Create the file `/etc/sddm.conf.d/autologin.conf` with the following content:

```ini
[Autologin]
User=<USERNAME> # Replace with your username
Session=hyprland
```

## Dual-boot Windows (GRUB)

1. Get the UUID of the Windows boot partition (will be FAT32, usually the first partition in the disk). For example: `26E2-5360`.

2. Open Grub Customizer and create a new entry. **Type**: "Other", **Boot sequence**:
    ```
    insmod part_gpt
    insmod fat
    search --no-floppy --fs-uuid --set=root <UUID>
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    ```

## Link `.vscode` directories

```bash
cd /my/project
mkdir .vscode
link-contents ~/.config/Code/vscode-dirs/[...] .vscode
```

## GUFW (Firewall GUI) profile

Launch gufw and select File > Import profile. Select [LC.profile](LC.profile). In the Profile dropdown, select Office.

Also run this command to allow the VPN to work:

```bash
sudo chmod u+s /usr/sbin/pppd
```

## Header editor (extension)

Go to "Export and Import" > "Import" and select [header-editor.json](header-editor.json).

## Hosts file

Append the contents of [hosts](hosts) to `/etc/hosts`.

## Redis connections

Open RedisInsight and click import (next to "Add Redis database"). Select [redis-connections.json](redis-connections.json).

## Epson printer over network

### Print

```bash
# Add the printer (replace PRINTER_NAME and PRINTER_IP)
lpadmin -p $PRINTER_NAME -E -v ipps://$PRINTER_IP/ipp/print -m everywhere
# Set as default
lpoptions -d $PRINTER_NAME
# List printers
lpstat -p -d
```

You can also use the CUPS web interface at [http://localhost:631/admin](http://localhost:631/admin).

### Scan

1. Install `sane`, `imagescan` and `imagescan-plugin-networkscan`.
2. Create the file `/etc/utsushi/utsushi.conf` with [this content](utsushi.conf) (may need to change the model and IP)
