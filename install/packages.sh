#!/bin/bash

# =============================================================================
# Sway (Wayland) Package Installation — Debian 13 (Trixie)
# =============================================================================

set -e

echo "--- Starting Sway (Wayland) installation for Debian 13 ---"

sudo apt update

echo "Installing Sway and XWayland..."
sudo apt install -y sway xwayland swaylock swayidle gtklock

echo "Installing Wayland UI utilities..."
sudo apt install -y waybar wofi mako-notifier alacritty gnome-themes-extra swayosd

echo "Installing screenshot and clipboard tools..."
sudo apt install -y grim slurp wl-clipboard

echo "Installing system controls..."
sudo apt install -y pavucontrol brightnessctl playerctl thunar libnotify-bin power-profiles-daemon

echo "Installing fonts..."
sudo apt install -y fonts-font-awesome fonts-jetbrains-mono fonts-noto-color-emoji

sudo apt autoremove -y

echo "--- Installation complete! ---"
echo "NOTE: If you use an NVIDIA GPU, launch sway with: sway --unsupported-gpu"
echo "Run link-configs.sh to set up configuration symlinks."
