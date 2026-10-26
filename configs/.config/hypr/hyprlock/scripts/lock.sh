#!/bin/bash

CURRENT_WALL=$(awww query | grep -oP 'image: \K.*')

if [ -n "$CURRENT_WALL" ]; then
    ln -sf "$CURRENT_WALL" "$HOME/.local/share/retro-dotfiles/current_wallpaper"
else
    ln -sf "$HOME/.config/hypr/wallpapers/archlinux.png" "$HOME/.local/share/retro-dotfiles/current_wallpaper"
fi

hyprlock
