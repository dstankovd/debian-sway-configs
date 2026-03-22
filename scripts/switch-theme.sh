#!/bin/bash

REPO="$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)"
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

# Update gtklock theme symlink
ln -sfn "$THEMES/active/gtklock.css" "$REPO/configs/gtklock/theme.css"

# Generate combined wofi CSS (wofi uses load_from_data so @import paths break)
{ cat "$THEMES/active/wofi.css"; grep -v '@import' "$REPO/configs/wofi/style.css"; } > ~/.config/wofi/style.css

# Apply GTK settings live via gsettings (affects running apps immediately)
GTK_INI="$THEMES/active/gtk-settings.ini"
if [ -f "$GTK_INI" ]; then
    GTK_THEME=$(awk -F'=' '/^gtk-theme-name/{gsub(/ /,"",$2); print $2}' "$GTK_INI")
    PREFER_DARK=$(awk -F'=' '/^gtk-application-prefer-dark-theme/{gsub(/ /,"",$2); print $2}' "$GTK_INI")
    GTK_FONT=$(awk -F'=' '/^gtk-font-name/{sub(/^[[:space:]]*/,"",$2); print $2}' "$GTK_INI")
    [ -n "$GTK_THEME" ] && gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
    [ -n "$GTK_FONT" ]  && gsettings set org.gnome.desktop.interface font-name "$GTK_FONT"
    if [ "$PREFER_DARK" = "1" ]; then
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    else
        gsettings set org.gnome.desktop.interface color-scheme 'default'
    fi
fi

# Trigger alacritty config reload in all open windows
touch ~/.config/alacritty/alacritty.toml

# Reload sway (exec_always in startup handles waybar restart)
swaymsg reload

# Reload mako
makoctl reload

echo "Done."
