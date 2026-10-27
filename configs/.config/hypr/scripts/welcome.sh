#!/bin/bash

FLAG_FILE="$HOME/.local/.has_launched"
WALLPAPER="$HOME/.config/hypr/wallpapers/archlinux.png"
WELCOME="$HOME/.local/share/retro-dotfiles/WELCOME.md"

reload_hyprland() {
    source "$HOME/.cache/wal/colors.sh"
    local C1="rgb(${color1:1})"
    local C2="rgb(${color2:1})"
    local BG="rgb(${background:1})"

    hyprctl eval "hl.config({ general = { col = { active_border = { colors = {'$C1', '$C2'}, angle = 45 }, inactive_border = '$BG' } } })"
}

reload_ashell() {
    cp "$HOME/.cache/wal/ashell.toml" "$HOME/.config/ashell/config.toml"
}

if [ ! -f "$FLAG_FILE" ]; then
    touch "$FLAG_FILE"

    awww img "$WALLPAPER" &
    wal -q -n -i "$WALLPAPER"

    reload_hyprland
    reload_ashell
    swaync-client -rs

    kitty --class retro-welcome -e glow -p "$WELCOME" &
fi
