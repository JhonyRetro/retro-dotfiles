#!/usr/bin/env bash

PS_DIR="/sys/class/power_supply"

GREEN="#A3BE8C"
YELLOW="#EBCB8B"
RED="#BF616A"

BAT=""
AC=""
for p in "$PS_DIR"/*; do
    case "$(cat "$p/type" 2>/dev/null)" in
        Battery)
            [ "$(cat "$p/scope" 2>/dev/null)" = "Device" ] && continue
            [ -z "$BAT" ] && [ -e "$p/capacity" ] && BAT="$p"
            ;;
        Mains)
            [ -z "$AC" ] && AC="$p"
            ;;
    esac
done

[ -z "$BAT" ] && exit 0

capacity=$(<"$BAT/capacity")

if [ -n "$AC" ]; then
    charging=$(<"$AC/online")
else
    [ "$(<"$BAT/status")" != "Discharging" ] && charging=1 || charging=0
fi

if   [ "$capacity" -ge 90 ]; then icon=$'\xef\x89\x80' 
elif [ "$capacity" -ge 60 ]; then icon=$'\xef\x89\x81' 
elif [ "$capacity" -ge 35 ]; then icon=$'\xef\x89\x82'
elif [ "$capacity" -ge 10 ]; then icon=$'\xef\x89\x83'
else                              icon=$'\xef\x89\x84'
fi
bolt=$'\xef\x83\xa7'

if [ "$charging" = "1" ]; then
    echo "<span foreground=\"$GREEN\">$bolt $icon  ${capacity}%</span>"
elif [ "$capacity" -le 10 ]; then
    echo "<span foreground=\"$RED\">$icon  ${capacity}%</span>"
elif [ "$capacity" -le 20 ]; then
    echo "<span foreground=\"$YELLOW\">$icon  ${capacity}%</span>"
else
    echo "$icon  ${capacity}%"
fi
