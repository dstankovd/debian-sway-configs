#!/bin/bash

# =============================================================================
# Link configs from this repo to ~/.config
# Safe to re-run — symlinks are updated in place.
# =============================================================================

set -e

REPO="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    echo "  linked $dst"
}

echo "--- Linking configs ---"

link "$REPO/configs/sway"              ~/.config/sway
link "$REPO/configs/waybar/config"     ~/.config/waybar/config
link "$REPO/configs/waybar/style.css"  ~/.config/waybar/style.css
link "$REPO/configs/mako/config"       ~/.config/mako/config
link "$REPO/configs/gtklock/style.css" ~/.config/gtklock/style.css
link "$REPO/configs/scripts"           ~/.config/scripts

echo "--- Done! ---"
