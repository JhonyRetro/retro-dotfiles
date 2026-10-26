#!/bin/bash

CURRENT_WALL=$(awww query | grep -oP 'image: \K.*')

if [ -n "$CURRENT_WALL" ]; then
    ln -sf "$CURRENT_WALL" /tmp/wallpaper
else
    ln -sf "$HOME/.config/hypr/wallpapers/archlinux.png" /tmp/wallpaper
fi

hyprlock
