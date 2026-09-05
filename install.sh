#!/usr/bin/env bash
set -uo pipefail

nvim_bkp_config="$HOME/.config/nvim-bkp"
nvim_config="$HOME/.config/nvim"
repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Check for the os version
if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    echo "$ID"
fi

rustcall() {
    if ! command -v cargo >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
        # shellcheck disable=SC1091
        source "$HOME/.cargo/env"
        rustup component add rust-src
    fi
}

case $ID in
ubuntu | kali)
    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo apt update -y
    sudo apt install git curl wget ripgrep fd-find unzip nodejs npm python3 python3-pip cmake make gcc neovim openjdk-25-jdk php php-cli dotnet-sdk-9.0 ruby-full -y
    mkdir -p ~/.local/bin
    ln -s "$(which fdfind)" ~/.local/bin/fd
    rustcall
    ;;
fedora)
    sudo dnf install curl wget neovim git ripgrep fd-find unzip nodejs npm python3 gcc cmake make java-25-openjdk-devel php php-cli dotnet-sdk-9.0 ruby ruby-devel -y
    rustcall
    ;;
arch | cachyos)
    sudo pacman -Syu git cmake make curl wget ruby dotnet-sdk php neovim ripgrep fd unzip nodejs npm python gcc --noconfirm
    rustcall
    ;;
*)
    echo "The OS is not supported"
    ;;
esac

# Copying the files
if [ -d "$nvim_bkp_config" ]; then
    rm -rf "$nvim_bkp_config"
fi

if [ -d "$nvim_config" ]; then
    mv "$nvim_config" "$nvim_bkp_config"
fi

if [ -d "$repo_root/nvim/" ]; then
    cp -r "$repo_root/nvim/" "$HOME/.config"
fi
