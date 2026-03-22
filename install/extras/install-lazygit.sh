#!/bin/bash

# =============================================================================
# Install latest Lazygit — from GitHub releases
# =============================================================================

set -e

echo "--- Installing Lazygit ---"

LATEST=$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
    | grep '"tag_name"' | cut -d'"' -f4)
VERSION="${LATEST#v}"

echo "Latest version: $LATEST"

TMP=$(mktemp -d)
curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/$LATEST/lazygit_${VERSION}_Linux_x86_64.tar.gz" \
    -o "$TMP/lazygit.tar.gz"

tar -C "$TMP" -xzf "$TMP/lazygit.tar.gz" lazygit
sudo mv "$TMP/lazygit" /usr/local/bin/lazygit
rm -rf "$TMP"

echo "--- Lazygit $LATEST installed. ---"
