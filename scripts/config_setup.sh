#!/bin/bash
set -e

echo "Step 2: Linking system configurations..."

if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is not installed. Make sure to run install_packages.sh if you haven't."
    exit 1
fi

DOTFILES_DIR="$(cd "../$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -d "$DOTFILES_DIR/configs" ]; then
    echo "Error: 'configs' folder not found in $DOTFILES_DIR. Make sure to clone the repository cleanly."
    exit 1
fi

echo "Linking 'configs/' contents to $HOME..."
cd "$DOTFILES_DIR"

stow -R -t "$HOME" configs

echo -e "\nStep 2 completed successfully!"
echo "retro-dotfiles' contents are now copied in your system."
