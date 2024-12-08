# Optional config

This directory contains optional configuration files that I wasn't able to automate.  
If you don't have the `dotfiles.key` file, some files will be encrypted and most steps below probably won't be useful to you.

## SDDM Autologin

Create the file `/etc/sddm.conf.d/autologin.conf` with the following content:

```ini
[Autologin]
User=<USERNAME> # Replace with your username
Session=hyprland
```

## Skip sudo/polkit password

1. Run `sudo visudo`
2. Add the following line at the end of the file (replace `your_username` with your username):
    ```
    your_username ALL=(ALL) NOPASSWD: ALL
    ```

Steps below are only required when using autologin.

3. Launch `seahorse` ("Passwords and Keys")
4. Right-click "Login" and select "Change password". Change it to a blank password.

## Dual-boot Windows (GRUB)

1. Get the UUID of the Windows boot partition (will be FAT32, usually the first partition in the disk). For example: `26E2-5360`.  
Use `lsblk -f` or your preferred GUI tool.

2. Open Grub Customizer and create a new entry. **Type**: "Other", **Boot sequence**:
    ```sh
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

Launch gufw and select File > Import profile. Select [LC.profile](LC.profile). In the Profile dropdown, make sure "LC" is selected.

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

Replace `PRINTER_NAME` and `PRINTER_IP` with a descriptive name and the IP address. The name cannot contain spaces.
```bash
# Add the printer
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
