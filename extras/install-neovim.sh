#!/bin/bash

# =============================================================================
# Install latest stable Neovim — from GitHub releases (tarball)
# =============================================================================

set -e

echo "--- Installing Neovim ---"

INSTALL_DIR="/opt/nvim"
LATEST=$(curl -fsSL https://api.github.com/repos/neovim/neovim/releases/latest \
    | grep '"tag_name"' | cut -d'"' -f4)

echo "Latest version: $LATEST"

TMP=$(mktemp -d)
curl -fsSL "https://github.com/neovim/neovim/releases/download/$LATEST/nvim-linux-x86_64.tar.gz" \
    -o "$TMP/nvim.tar.gz"

sudo rm -rf "$INSTALL_DIR"
sudo tar -C /opt -xzf "$TMP/nvim.tar.gz"
sudo mv /opt/nvim-linux-x86_64 "$INSTALL_DIR"
rm -rf "$TMP"

# Symlink into PATH
sudo ln -sf "$INSTALL_DIR/bin/nvim" /usr/local/bin/nvim

echo "--- Neovim $LATEST installed. ---"
