#!/bin/bash
set -e

echo "Step 2: Linking system configurations..."

if ! command -v stow &> /dev/null; then
    echo "Error: GNU Stow is not installed. Make sure to run install_packages.sh if you haven't."
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ ! -d "$DOTFILES_DIR/configs" ]; then
    echo "Error: 'configs' folder not found in $DOTFILES_DIR. Make sure to clone the repository cleanly."
    exit 1
fi

if [ -f "$HOME/.zshrc" ]; then
	rm -f $HOME/.zshrc
fi

echo "Linking 'configs/' contents to $HOME..."
cd "$DOTFILES_DIR"

stow -R -t "$HOME" configs

echo "Generating default wallpaper and color palette..."
sudo ln -sf "$HOME/.config/hypr/wallpapers/archlinux.png" "$HOME/.local/share/retro-dotfiles/current_wallpaper"

if command -v wal &> /dev/null; then
	wal -i "$HOME/.local/share/retro-dotfiles/current_wallpaper" -n -q
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
