#!/bin/bash
# First login
FLAG_FILE="$HOME/.local/.has_launched"

if [ ! -f "$FLAG_FILE" ]; then
    awww img "$HOME/.config/hypr/wallpapers/current_wallpaper" &
    
    kitty --hold -e glow "$HOME/.local/share/retro-dotfiles/WELCOME.md" &
    
    touch "$FLAG_FILE"
fi

