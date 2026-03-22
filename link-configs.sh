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
    ln -sfn "$src" "$dst" 2>/dev/null || true
    echo "  linked $dst"
}

echo "--- Linking configs ---"

link "$REPO/configs/sway"              ~/.config/sway
link "$REPO/configs/waybar/config"     ~/.config/waybar/config
link "$REPO/configs/waybar/style.css"  ~/.config/waybar/style.css
link "$REPO/configs/gtklock/style.css" ~/.config/gtklock/style.css
link "$REPO/configs/scripts"           ~/.config/scripts
link "$REPO/configs/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
link "$REPO/configs/wofi/config"       ~/.config/wofi/config
# Generate combined wofi CSS (wofi uses load_from_data so @import paths break)
{ cat "$REPO/themes/active/wofi.css"; grep -v '@import' "$REPO/configs/wofi/style.css"; } > ~/.config/wofi/style.css
echo "  generated ~/.config/wofi/style.css"
link "$REPO/configs/gtklock/theme.css" ~/.config/gtklock/theme.css
link "$REPO/themes"                    ~/.config/themes

# mako config points at active theme
ln -sf "$REPO/themes/active/mako" ~/.config/mako/config
echo "  linked ~/.config/mako/config"

echo "--- Done! ---"
