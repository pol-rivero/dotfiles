# Manual config

This directory contains configuration files that I wasn't able to automate.  
If you don't have the `dotfiles.key` file, some files will be encrypted and most steps below probably won't be useful to you.

## Skip prompts in `yay`

```bash
yay --save --answerdiff None --answerclean None --removemake
```

## GUFW (Firewall GUI) profile

Launch gufw and select File > Import profile. Select [Office.profile](Office.profile). In the Profile dropdown, select Office.

## Header editor (extension)

Go to "Export and Import" > "Import" and select [header-editor.json](header-editor.json).

## Hosts file

Append the contents of [hosts](hosts) to `/etc/hosts`.

## Redis connections

Open RedisInsight and click import (next to "Add Redis database"). Select [redis-connections.json](redis-connections.json).

## Epson scanner over network

1. Install `sane`, `imagescan` and `imagescan-plugin-networkscan`.
2. Create the file `/etc/utsushi/utsushi.conf` with [this content](utsushi.conf) (may need to change the model and IP)
