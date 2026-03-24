#!/bin/bash

REPO="$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)"
THEMES="$REPO/themes"
TEMPLATES="$THEMES/templates"

if [ -z "$1" ]; then
    echo "Usage: switch-theme.sh <theme-name>"
    echo "Available themes:"
    ls "$THEMES" | grep -Ev '^templates$'
    exit 1
fi

THEME="$1"
COLORS="$THEMES/$THEME/colors.sh"

if [ ! -f "$COLORS" ]; then
    echo "Error: theme '$THEME' not found in $THEMES"
    exit 1
fi

echo "Switching to theme: $THEME"

# Load color variables into the environment
set -a
# shellcheck source=/dev/null
source "$COLORS"
set +a

render() { envsubst < "$TEMPLATES/$1"; }

# Generate all theme-specific configs directly to ~/.config/
mkdir -p ~/.config/mako \
         ~/.config/swayosd \
         ~/.config/gtklock \
         ~/.config/waybar \
         ~/.config/wofi \
         ~/.config/sway \
         ~/.config/alacritty \
         ~/.config/foot \
         ~/.config/gtk-3.0 \
         ~/.config/gtk-4.0

render mako             > ~/.config/mako/config
render swayosd.css      > ~/.config/swayosd/style.css
render gtklock.css      > ~/.config/gtklock/theme.css
render waybar.css       > ~/.config/waybar/style.css
render wofi.css         > ~/.config/wofi/style.css
render sway             > ~/.config/sway/colors
rm -f ~/.config/alacritty/alacritty.toml && render alacritty.toml > ~/.config/alacritty/alacritty.toml
rm -f ~/.config/foot/foot.ini            && render foot.ini       > ~/.config/foot/foot.ini
render gtk-settings.ini > ~/.config/gtk-3.0/settings.ini
render gtk-settings.ini > ~/.config/gtk-4.0/settings.ini

# Track active theme
mkdir -p ~/.config/themes
echo "$THEME" > ~/.config/themes/current

# Apply GTK settings live (affects running apps immediately)
[ -n "$GTK_THEME" ] && gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
[ -n "$GTK_FONT" ] && gsettings set org.gnome.desktop.interface font-name "$GTK_FONT"
if [ "$GTK_COLOR_SCHEME" = "prefer-dark" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
else
    gsettings set org.gnome.desktop.interface color-scheme 'default'
fi

# Reload sway (exec_always in startup handles waybar restart)
swaymsg reload 2>/dev/null || true

# Reload mako
makoctl reload 2>/dev/null || true

# Restart swayosd with new theme
pkill -x swayosd-server 2>/dev/null; swayosd-server &

echo "Done."
