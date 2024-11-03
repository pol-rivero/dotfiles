#!/usr/bin/python3

import os
import subprocess
import time

AUR_HELPER = "yay"

def main():
    # Avoid checking on each panel restart: check if 15 minutes passed.
    # Adjust the time (in seconds) to your liking.
    # Make sure if the path below matches your temp directory.
    file = "/tmp/arch-updates"
    
    if os.path.isfile(file):
        if int(time.time() - os.stat(file).st_mtime) > 900:
            arch, aur = check_updates()
            save_string("{},{}".format(arch, aur), file)
        else:
            try:
                vals = load_string(file).split(",")
                arch, aur = int(vals[0]), int(vals[1])
            except:
                arch, aur = 0, 0
    else:
        arch, aur = check_updates()
        save_string("{},{}".format(arch, aur), file)

    if arch > 0 and aur > 0:
        print("󱍷 {}/{}".format(arch, aur))
    elif arch > 0:
        print("󱍷 {}".format(arch))
    elif aur > 0:
        print("󱍷 {}".format(aur))


def save_string(string, file):
    try:
        file = open(file, "wt")
        file.write(string)
        file.close()
    except:
        print("Error writing file '{}'".format(file))


def load_string(path):
    try:
        with open(path, 'r') as file:
            data = file.read()
            return data
    except:
        return ""


def check_updates():
    arch, aur = 0, 0
    try:
        arch = len(subprocess.check_output(["checkupdates"]).decode("utf-8").splitlines())
    except:
        pass
    try:
        aur = len(subprocess.check_output([AUR_HELPER, "-Qqu", "-a"]).decode("utf-8").splitlines())
    except:
        pass

    return arch, aur


if __name__ == "__main__":
    main()
