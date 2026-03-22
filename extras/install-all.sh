#!/bin/bash

# =============================================================================
# Install all extras
# =============================================================================

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

"$DIR/install-vscode.sh"
"$DIR/install-neovim.sh"
"$DIR/install-lazygit.sh"

echo "--- All extras installed. ---"
