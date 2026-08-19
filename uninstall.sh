#!/bin/bash

set -e
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "WARNING! This script will unlink all stowed configuration files"
echo "and will revert the dotfiles' installation."
echo ""

read -p "Are you sure you want to uninstall 'retro-dotfiles' from your system? (y/N): " confirmar
if [[ ! "$confirmar" =~ ^[Yy]$ ]]; then
    echo "Uninstall aborted."
    exit 0
fi

sudo -v

echo -e "\nReversing user configuration files..."
if command -v stow &> /dev/null; then
    stow -D -t "$HOME" configs
    echo "Links successfully removed from $HOME."
else
    echo "GNU Stow is not installed, skipping..."
fi

echo -e "\nReversing system configuration files..."
if [ -d "$DOTFILES_DIR/system" ]; then
    sudo stow -d "$DOTFILES_DIR" -D -t / system
    echo "Links successfully removed from /etc."
    
    if [ -f "/etc/ly/config.bak" ]; then
        sudo mv /etc/ly/config.bak /etc/ly/config.ini
        echo "Ly config backup restored."
    fi
else
    echo "'system' folder not found, skipping..."
fi

read -p "Do you want to uninstall Oh My Zsh? (y/N): " desinstalar_omz
if [[ "$desinstalar_omz" =~ ^[Yy]$ ]] && [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Uninstalling Oh My Zsh..."
    env ZSH="$HOME/.oh-my-zsh" sh "$HOME/.oh-my-zsh/tools/uninstall.sh"
    echo "Oh My Zsh removed."
else
    echo "Oh My Zsh kept."
fi

echo "Dotfiles successfully uninstalled."
echo "You may now restart your system."
