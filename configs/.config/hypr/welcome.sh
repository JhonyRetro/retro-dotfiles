#!/bin/bash
# First login
FLAG_FILE="$HOME/.local/.has_launched"

if [ ! -f "$FLAG_FILE" ]; then
    kitty --hold -e glow "$HOME/.local/share/retro-dotfiles/WELCOME.md" &
    
    touch "$FLAG_FILE"
fi

reload_ashell() {
    if [ -f "$HOME/.cache/wal/colors.sh" ]; then
        source "$HOME/.cache/wal/colors.sh"
    else
        echo "Error: Pywal colors not found in cache."
        return 1
    fi
    
    local ASHELL_CONF="$HOME/.config/ashell/config.toml"
    
    if [ ! -f "$ASHELL_CONF" ]; then
        echo "Error: File $ASHELL_CONF not found."
        return 1
    fi
    sed -i "s/^success_color = .*/success_color = \"$color2\"/" "$ASHELL_CONF"
    sed -i "s/^warning_color = .*/warning_color = \"$color3\"/" "$ASHELL_CONF"
    sed -i "s/^danger_color = .*/danger_color = \"$color1\"/" "$ASHELL_CONF"
    sed -i "s/^text_color = .*/text_color = \"$foreground\"/" "$ASHELL_CONF"
    sed -i "s/^workspace_colors = .*/workspace_colors = [ \"$color4\", \"$color5\", \"$color6\" ]/" "$ASHELL_CONF"
    
    sed -i '/\[appearance\.primary_color\]/,/\[appearance\.background_color\]/ s/^base = .*/base = "'$color4'"/' "$ASHELL_CONF"
    sed -i '/\[appearance\.primary_color\]/,/\[appearance\.background_color\]/ s/^text = .*/text = "'$background'"/' "$ASHELL_CONF"
    
    sed -i '/\[appearance\.background_color\]/,$ s/^base = .*/base = "'$background'"/' "$ASHELL_CONF"
    sed -i '/\[appearance\.background_color\]/,$ s/^weak = .*/weak = "'$color0'"/' "$ASHELL_CONF"
    sed -i '/\[appearance\.background_color\]/,$ s/^strong = .*/strong = "'$color8'"/' "$ASHELL_CONF"
    
    killall ashell > /dev/null 2>&1
    ashell & disown
}

reload_hyprland(){
    source "$HOME/.cache/wal/colors.sh"
    C1="rgb(${color1:1})"
    C2="rgb(${color2:1})"
    BG="rgb(${background:1})"
    
    LUA_CMD="hl.config({ general = { col = { active_border = { colors = {'$C1', '$C2'}, angle = 45 }, inactive_border = '$BG' } } })"

    hyprctl eval "$LUA_CMD"
}

awww img "$HOME/.local/share/retro-dotfiles/current_wallpaper" &

wal -q -i "$HOME/.local/share/retro-dotfiles/current_wallpaper"

reload_hyprland

reload_ashell

swaync-client -rs
