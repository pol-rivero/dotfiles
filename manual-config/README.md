# Manual config

This directory contains configuration files that I wasn't able to automate.  
If you don't have the `dotfiles.key` file, some files will be encrypted and most steps below probably won't be useful to you.

## GUFW (Firewall GUI)

1. Modify `/usr/share/applications/gufw.desktop` and replace `Exec=gufw` with:

   `Exec=sh -c "xhost +si:localuser:root && gufw && xhost -si:localuser:root"`

2. (Optional) Launch gufw and select File > Import profile. Select [Office.profile](Office.profile). In the Profile dropdown, select Office.

## Header editor (extension)

Go to "Export and Import" > "Import" and select [header-editor.json](header-editor.json).

## Hosts file

Append the contents of [hosts](hosts) to `/etc/hosts`.

## Redis connections

Open RedisInsight and click import (next to "Add Redis database"). Select [redis-connections.json](redis-connections.json).
