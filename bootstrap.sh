#!/usr/bin/env bash
set -uo pipefail

# nvim-config bootstrap — usage:
#   curl -fsSL https://raw.githubusercontent.com/0xhealer/nvim-config/main/bootstrap.sh | bash
#
# Downloads the repo (tarball, not git clone — git isn't guaranteed to be on
# a fresh machine yet, tar is) and hands off to install.sh.

REPO_URL="https://github.com/0xhealer/nvim-config"
INSTALL_DIR="$HOME/.local/share/nvim-config"

echo "Downloading nvim-config to $INSTALL_DIR..."
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
curl -fsSL "$REPO_URL/archive/refs/heads/main.tar.gz" | tar -xz -C "$INSTALL_DIR" --strip-components=1

exec bash "$INSTALL_DIR/install.sh"
