#!/bin/bash
set -e

echo "Step 2: Linking system configurations..."

if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is not installed. Make sure to run install_packages.sh if you haven't."
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "Current wd: $DOTFILES_DIR"
if [ ! -d "$DOTFILES_DIR/configs" ]; then
    echo "Error: 'configs' folder not found in $DOTFILES_DIR. Make sure to clone the repository cleanly."
    exit 1
fi

echo "Linking 'configs/' contents to $HOME..."
cd "$DOTFILES_DIR"

stow -R -t "$HOME" configs

echo "Generating default wallpaper and color palette..."
ln -sf "$HOME/.config/hypr/wallpapers/archlinux.png" /tmp/wallpaper
if command -v wal &> /dev/null; then
	wal -i -n -q "/tmp/wallpaper"
	echo "Color palette generated successfully."
else
	echo "Pywal is not installed, skipping..."
fi

echo "Applying GTK settings..."
GTK_THEME="adw-gtk3-dark"
ICON_THEME="Papirus-Dark"

gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

echo "Settings applied to dconf."

echo -e "\nStep 2 completed successfully!"
echo "retro-dotfiles' contents are now copied in your system."
