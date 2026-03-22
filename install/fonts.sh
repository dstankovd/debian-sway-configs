#!/bin/bash

# =============================================================================
# Font Installation Script
# Installs JetBrainsMono Nerd Font (coding font + icons in one)
# =============================================================================

set -e

FONT_DIR="$HOME/.local/share/fonts/NerdFonts"
NERD_FONTS_VERSION="v3.3.0"
FONT_NAME="JetBrainsMono"
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${NERD_FONTS_VERSION}/${FONT_NAME}.tar.xz"

echo "--- Installing JetBrainsMono Nerd Font ---"

mkdir -p "$FONT_DIR"

TMP=$(mktemp -d)
trap "rm -rf $TMP" EXIT

echo "Downloading ${FONT_NAME} Nerd Font ${NERD_FONTS_VERSION}..."
curl -L "$DOWNLOAD_URL" -o "$TMP/${FONT_NAME}.tar.xz"

echo "Extracting..."
tar -xf "$TMP/${FONT_NAME}.tar.xz" -C "$TMP"

# Copy only the fonts we care about (no Windows-compatible variants)
find "$TMP" -name "*.ttf" ! -name "*Windows*" -exec cp {} "$FONT_DIR/" \;

echo "Refreshing font cache..."
fc-cache -fv "$FONT_DIR"

echo "--- Done! Installed fonts: ---"
fc-list | grep -i "JetBrainsMono" | sort
