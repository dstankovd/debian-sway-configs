#!/bin/bash

# =============================================================================
# Link non-themed configs from this repo to ~/.config, then apply active theme.
# Safe to re-run — symlinks are updated in place.
# =============================================================================

set -e

REPO="$(cd "$(dirname "$0")/.." && pwd)"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    echo "  linked $dst"
}

echo "--- Linking configs ---"

link "$REPO/configs/sway"                        ~/.config/sway
link "$REPO/configs/waybar/config"               ~/.config/waybar/config
link "$REPO/configs/gtklock/style.css"           ~/.config/gtklock/style.css
link "$REPO/configs/wofi/config"                 ~/.config/wofi/config
link "$REPO/scripts"                             ~/.config/scripts

echo "--- Applying theme ---"

# Use the last applied theme, defaulting to flexoki-dark
THEME="flexoki-dark"
if [ -f ~/.config/themes/current ]; then
    THEME="$(cat ~/.config/themes/current)"
fi

"$REPO/scripts/switch-theme.sh" "$THEME"

echo "--- Done! ---"
