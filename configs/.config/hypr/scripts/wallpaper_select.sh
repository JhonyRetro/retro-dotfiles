#!/bin/bash
reload_ashell() {
    local GENERATED="$HOME/.cache/wal/ashell.toml"

    if [ ! -f "$GENERATED" ]; then
        echo "Error: pywal has not generated $GENERATED."
        return 1
    fi

    mkdir -p "$HOME/.config/ashell"
    cp "$GENERATED" "$HOME/.config/ashell/config.toml"

    killall ashell > /dev/null 2>&1
    ashell & disown
}

reload_hyprland() {
    source "$HOME/.cache/wal/colors.sh"
    local C1="rgb(${color1:1})"
    local C2="rgb(${color2:1})"
    local BG="rgb(${background:1})"

    hyprctl eval "hl.config({ general = { col = { active_border = { colors = {'$C1', '$C2'}, angle = 45 }, inactive_border = '$BG' } } })"
}

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
APPLY_CMD="awww img" 

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: $WALLPAPER_DIR not found."
    exit 1
fi

SELECTION=$(
	for img in "$WALLPAPER_DIR"/*; do
        if [[ -f "$img" && "$img" =~ \.(jpg|jpeg|png|gif|webp)$ ]]; then
            name=$(basename "$img")
            echo -en "${name}\0icon\x1f${img}\n"
        fi
    done | rofi -dmenu -i -show-icons \
        -theme-str 'element-icon { size: 10ch; }' \
        -p "🖼️ Wallpaper:"
)

if [ -n "$SELECTION" ]; then
    WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTION"
    
    $APPLY_CMD "$WALLPAPER_PATH"

    wal -q -i "$WALLPAPER_PATH"
    
    reload_hyprland

    reload_ashell

    swaync-client -rs

    ln -sf "$WALLPAPER_PATH" "$HOME/.local/share/retro-dotfiles/current_wallpaper"
   
    notify-send "Wallpaper changed!" "Applied: $SELECTION"
fi
