#!/bin/bash

# =============================================================================
# Sway (Wayland) Setup Script for Debian 13 (Trixie)
# =============================================================================

# Exit on error
set -e

echo "--- Starting Sway (Wayland) installation for Debian 13 ---"

# 1. Update package lists
sudo apt update

# 2. Install Sway and XWayland
# XWayland allows you to run older X11 apps seamlessly inside Sway.
echo "Installing Sway and XWayland..."
sudo apt install -y sway xwayland swaylock swayidle

# 3. Install Core Wayland Utilities
# - waybar: Highly customizable status bar
# - wofi: Wayland-native app launcher
# - mako-notifier: Lightweight notification daemon
# - foot: Extremely fast Wayland-native terminal (or alacritty)
echo "Installing Wayland UI utilities..."
sudo apt install -y waybar wofi mako-notifier foot

# 4. Install Screenshot and Clipboard Tools
# - grim: Grab images from Wayland
# - slurp: Select a region on screen
# - wl-clipboard: Wayland clipboard manager
echo "Installing screenshot and clipboard tools..."
sudo apt install -y grim slurp wl-clipboard

# 5. Install System & Media Controls
# - pavucontrol: Audio management
# - brightnessctl: Screen brightness
# - playerctl: Media control
# - thunar: File manager
echo "Installing system controls..."
sudo apt install -y pavucontrol brightnessctl playerctl thunar

# 6. Install Fonts and Icons
# Essential for Waybar icons and clean text.
echo "Installing fonts..."
sudo apt install -y fonts-font-awesome fonts-jetbrains-mono fonts-noto-color-emoji

# 7. Create Configuration Directories
echo "Creating config directories..."
mkdir -p ~/.config/sway
mkdir -p ~/.config/waybar
mkdir -p ~/.config/foot
mkdir -p ~/.config/mako

# 8. Copy Default Sway Config
# This gives you a working base to customize later.
if [ ! -f ~/.config/sway/config ]; then
    cp /etc/sway/config ~/.config/sway/config
    echo "Default Sway config copied to ~/.config/sway/config"
fi

# 9. Clean up
sudo apt autoremove -y

echo "--- Installation Complete! ---"
echo "NOTE: If you use an NVIDIA GPU, you may need to launch sway with: "
echo "      'sway --unsupported-gpu'"
echo "Log out and select 'Sway' from your login manager (GDM/SDDM)."

# Optional Reboot Prompt
read -p "Would you like to reboot now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot
fi
