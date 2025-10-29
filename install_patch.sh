#!/bin/bash

SWBF2_PATH="$HOME/.local/share/Steam/steamapps/common/Star Wars Battlefront II Classic/GameData"
PATCH_DIR="$(pwd)"

LVL_DIR="$SWBF2_PATH/data/_lvl_pc"
SIDES_DIR="$SWBF2_PATH/data/_lvl_pc/side"
SETTINGS_DIR="/home/squishy/.local/share/Steam/steamapps/common/Star Wars Battlefront II Classic/v1.3patch/settings"

# Verify game installation exists
if [ ! -f "$SWBF2_PATH/BattlefrontII.exe" ]; then
    echo "ERROR: Game installation not found at $SWBF2_PATH"
    echo "Please verify the path and try again."
    exit 1
fi

# Check if xdelta3 is installed
if ! command -v xdelta3 &> /dev/null; then
    echo "xdelta3 not found. Install it with:"
    echo "  Ubuntu/Debian: sudo apt install xdelta3"
    echo "  Arch: sudo pacman -S xdelta3"
    echo "  Fedora: sudo dnf install xdelta"
    exit 1
fi

# Check if the data directory exists
if [ ! -d "$LVL_DIR" ]; then
    echo "ERROR: Could not find $LVL_DIR"
    exit 1
fi

echo "=== Star Wars Battlefront II - Unofficial v1.3 Patch Installer ==="
echo ""
echo "Game path: $SWBF2_PATH"
echo "LVL path: $LVL_DIR"
echo "Sides path: $SIDES_DIR"
echo "Patch directory: $PATCH_DIR"
echo ""
read -p "Continue with installation? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "Installing v1.3 Unofficial Patch..."
echo ""

# Create settings directory
mkdir -p "$SETTINGS_DIR"

# Apply patches to main LVL files
echo "Patching main LVL files..."
for file in common.lvl ingame.lvl shell.lvl; do
    echo "  Patching $file"
    rm -f "$LVL_DIR/$file"
    xdelta3 -d -s "$PATCH_DIR/retail/${file}.retail" "$PATCH_DIR/patch/${file}_v1.3patch" "$LVL_DIR/$file"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to patch $file"
        exit 1
    fi
done

# Apply patches to side files
echo ""
echo "Patching side files..."
for file in all.lvl imp.lvl rep.lvl cis.lvl allshell.lvl impshell.lvl repshell.lvl cisshell.lvl; do
    echo "  Patching $file"
    rm -f "$SIDES_DIR/$file"
    xdelta3 -d -s "$PATCH_DIR/retail/${file}.retail" "$PATCH_DIR/patch/${file}_v1.3patch" "$SIDES_DIR/$file"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to patch $file"
        exit 1
    fi
done

# Copy strings
echo ""
echo "Copying strings..."
cp "$PATCH_DIR/strings/v1.3patch_strings.lvl" "$LVL_DIR/v1.3patch_strings.lvl"

# Copy preview movie
echo ""
echo "Copying preview movie..."
mkdir -p "$LVL_DIR/movies"
cp "$PATCH_DIR/movie/pre-movie.mvs" "$LVL_DIR/movies/pre-movie.mvs"

# Create settings files
echo ""
echo "Creating settings files..."
echo "This file tells the UnOfficial v1.3 patch's menu system that the v1.3 patch is installed" > "$SETTINGS_DIR/installed.txt"
echo "This file tells the UnOfficial v1.3 patch's menu system that the custom HUD is being used" > "$SETTINGS_DIR/hasHud.txt"
echo "This file tells the UnOfficial v1.3 patch's menu system that the custom sides are being used" > "$SETTINGS_DIR/hasSides.txt"

echo ""
echo "=========================================="
echo "Installation complete!"
echo "Have a nice day and enjoy."
echo "=========================================="
