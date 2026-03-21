#!/bin/bash

REPO="$(cd "$(dirname "$0")/../.." && pwd)"
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

# Reload everything
swaymsg reload
pkill -x waybar; waybar &
makoctl reload

echo "Done."
