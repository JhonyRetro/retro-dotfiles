#!/bin/bash
set -e

echo "Step 1: Package installation"

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing base dependencies..."
sudo pacman -S --needed --noconfirm base-devel git curl

if ! command -v yay &> /dev/null; then
    echo "AUR Helper not found. Installing 'yay'"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd - > /dev/null
    rm -rf /tmp/yay
    echo "yay installed successfully."
else
    echo "yay is already installed."
fi

PKG_FILE="pkg.lst"

if [ -f "$PKG_FILE" ]; then
    echo "Reading package list: $PKG_FILE..."
    
    PACKAGES=$(grep -vE "^\s*#|^\s*$" "$PKG_FILE" | tr '\n' ' ')
    echo "Installing packages..."
    yay -S --needed $PACKAGES
else
    echo "Error: File $PKG_FILE not found."
    exit 1
fi

read -p "Would you like to install Oh My Zsh? (s/N): " instalar_omz

if [[ "$instalar_omz" =~ ^[Ss]$ ]]; then
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Downloading and installing Oh My Zsh..."
        RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo -e "Oh My Zsh installed correctly.\n"
    else
        echo -e "Oh My Zsh might already be installed (~/.oh-my-zsh exists).\n"
    fi
else
    echo -e "Skipping Oh My Zsh installation.\n"
fi

echo -e "\nStep 1 completed! All needed packages are installed."
