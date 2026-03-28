#!/bin/bash

# =============================================================================
# Fix washed-out colors on AMD laptops — disable Adaptive Backlight Management
#
# What this does:
#   - Sets amdgpu abmlevel=0 (ABM disabled) via a modprobe config
#   - Applies the change immediately without a reboot
#
# Background:
#   AMD's ABM dims the backlight and compensates with gamma adjustments to
#   save power. On battery/power-saver mode this causes desaturated, washed-out
#   colors. Setting abmlevel=0 disables this entirely.
#
# AMD-only. Safe to run on non-AMD hardware (the modprobe config is ignored).
# =============================================================================

set -e

MODPROBE_CONF=/etc/modprobe.d/amdgpu-abm.conf
ABM_PARAM=/sys/module/amdgpu/parameters/abmlevel

echo "--- Disabling AMD Adaptive Backlight Management (ABM) ---"

echo "options amdgpu abmlevel=0" | sudo tee "$MODPROBE_CONF"
echo "  Written: $MODPROBE_CONF  (persists after reboot)"

if [ -f "$ABM_PARAM" ]; then
    echo 0 | sudo tee "$ABM_PARAM" > /dev/null
    echo "  Applied immediately: abmlevel=$(cat "$ABM_PARAM")"
else
    echo "  Note: $ABM_PARAM not found — change will take effect after reboot"
fi

echo "--- Done. Colors should look correct on all power profiles. ---"
