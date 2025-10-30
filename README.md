# SWBF2 Unofficial v1.3 Patch - Linux Install Script

Bash script to install the Star Wars Battlefront II (2005) Unofficial v1.3 Patch on systems running Linux.

## Background

Recently, I've been trying to de-Windows my life and I wanted to install some mods for Star Wars Battlefront 2 on my desktop PC. I found that the files included in the unofficial v1.3 patch 
are basically Windows only. With this script, you'll be able to install the unofficial v1.3 patch on most Linux systems. 

You can get the patch from this guide: [JASPO'S STAR WARS BATTLEFRONT II MAP COLLECTION](https://steamcommunity.com/sharedfiles/filedetails/?id=1493175096)

## Requirements

- `xdelta3` 
- The [original v1.3 patch files](https://steamcommunity.com/sharedfiles/filedetails/?id=1493175096)

## Usage

Make sure to install the `xdelta3` package for your distro. This assumes you have the version distributed from Steam. 

1. Get the unofficial v1.3 patch from the link above
2. Extract the patch from the .7z archive
3. Inside of the folder there is a folder named `old 1_3 patch stuff` copy the folder named `v1.3patch` into a working directory
4. Download the script from this repository
5. Place the script inside of the `v1.3patch` folder, where the `menu.bat` file exists
6. Run: `chmod +x install_patch.sh`
7. Run: `./install_patch.sh`
8. Should work! Enjoy a patched version of SWBF2 running on Linux!!!
