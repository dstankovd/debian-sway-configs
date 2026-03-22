#!/bin/bash

REPO="$(cd "$(dirname "$(readlink -f "$0")")/../.." && pwd)"
THEMES="$REPO/themes"

if [ -z "$1" ]; then
    echo "Usage: switch-theme.sh <theme-name>"
    echo "Available themes:"
    ls "$THEMES" | grep -v '^active$'
    exit 1
fi

THEME="$1"

if [ ! -d "$THEMES/$THEME" ]; then
    echo "Error: theme '$THEME' not found in $THEMES"
    exit 1
fi

echo "Switching to theme: $THEME"

# Update active symlink
ln -sfn "$THEMES/$THEME" "$THEMES/active"

# Update mako config symlink
ln -sf "$THEMES/active/mako" ~/.config/mako/config

# Trigger alacritty config reload in all open windows
touch ~/.config/alacritty/alacritty.toml

# Reload sway (exec_always in startup handles waybar restart)
swaymsg reload

# Reload mako
makoctl reload

echo "Done."
