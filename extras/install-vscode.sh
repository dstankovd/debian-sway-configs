#!/bin/bash

# =============================================================================
# Install Visual Studio Code — via Microsoft apt repository
# =============================================================================

set -e

echo "--- Installing VS Code ---"

if ! grep -rq "packages.microsoft.com/repos/code" /etc/apt/sources.list.d/ 2>/dev/null; then
    echo "Adding Microsoft apt repository..."

    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
        | gpg --dearmor \
        | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null

    echo "Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/microsoft.gpg" \
        | sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null
else
    echo "Microsoft repo already configured, skipping."
fi

sudo apt update
sudo apt install -y code

echo "--- VS Code installed. ---"
