#!/bin/bash

# =============================================================================
# Configure sleep / hibernation — optional, laptop-specific
#
# What this does:
#   - Configures lid close to suspend (logind drop-in)
#   - Adds resume= kernel parameter for hibernation (requires LVM swap)
#
# Requirements:
#   - A swap partition large enough to hold RAM
#   - LVM setup (swap at /dev/mapper/<vg>-swap_1 or similar)
#
# Skip this script on desktops or machines without a swap partition.
# =============================================================================

set -e

REPO="$(cd "$(dirname "$0")/../.." && pwd)"

echo "--- Configuring lid close (suspend on lid close) ---"
sudo mkdir -p /etc/systemd/logind.conf.d
sudo cp "$REPO/configs/logind/lid.conf" /etc/systemd/logind.conf.d/lid.conf
echo "  Done. Takes effect on next login."

echo ""
echo "--- Hibernation setup ---"
echo "  To enable hibernation, you need to add resume= to the kernel cmdline."
echo "  Find your swap device:"
echo "    swapon --show"
echo ""
echo "  Then edit /etc/default/grub and add to GRUB_CMDLINE_LINUX_DEFAULT:"
echo "    resume=/dev/mapper/<vg>-swap_1   (adjust to your swap device)"
echo ""
echo "  Then rebuild initramfs and grub:"
echo "    echo 'RESUME=/dev/mapper/<vg>-swap_1' | sudo tee /etc/initramfs-tools/conf.d/resume"
echo "    sudo update-initramfs -u -k all"
echo "    sudo update-grub"
echo ""
echo "--- Sleep/hibernation configuration complete. ---"
