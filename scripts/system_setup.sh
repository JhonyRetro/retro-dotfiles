#!/bin/bash
set -e

echo "Step 3: Configuring system services..."

sudo -v

echo "Enabling NetworkManager..."
sudo systemctl enable NetworkManager.service

echo "Enabling Bluetooth..."
sudo systemctl enable bluetooth.service

echo "Enabling TLP..."
sudo systemctl enable tlp.service

echo "Enabling Ly login manager..."
sudo systemctl enable -f ly@tty1.service

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "Linking ly configuration..."
sudo mv /etc/ly/config.ini /etc/ly/config.bak
sudo stow -d "$DOTFILES_DIR" -R -t / system

echo "Step 3 completed successfully!"
echo "All necessary services are now enabled."
