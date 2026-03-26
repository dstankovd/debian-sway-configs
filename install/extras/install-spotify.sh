#!/bin/bash

# =============================================================================
# Install Spotify — via official Spotify apt repository
# =============================================================================

set -e

echo "--- Installing Spotify ---"

if ! grep -rq "repository.spotify.com" /etc/apt/sources.list.d/ 2>/dev/null; then
    echo "Adding Spotify apt repository..."

    curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc \
        | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg

    echo "deb https://repository.spotify.com stable non-free" \
        | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null
else
    echo "Spotify repo already configured, skipping."
fi

sudo apt-get update
sudo apt-get install -y spotify-client

echo "--- Spotify installed. ---"
