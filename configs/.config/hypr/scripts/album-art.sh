#!/usr/bin/env bash

CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/hyprlock-art"
EMPTY="$CACHE/empty.png"
mkdir -p "$CACHE"

if [ ! -f "$EMPTY" ]; then
    echo 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVR4nGNgAAIAAAUAAXpeqz8AAAAASUVORK5CYII=' \
        | base64 -d > "$EMPTY"
fi

show_empty() {
    echo "$EMPTY"
    exit 0
}

command -v playerctl > /dev/null || show_empty

url=""
paused_url=""
while read -r player; do
    case "$(playerctl -p "$player" status 2>/dev/null)" in
        Playing)
            url=$(playerctl -p "$player" metadata mpris:artUrl 2>/dev/null)
            [ -n "$url" ] && break
            ;;
        Paused)
            [ -z "$paused_url" ] && paused_url=$(playerctl -p "$player" metadata mpris:artUrl 2>/dev/null)
            ;;
    esac
done < <(playerctl -l 2>/dev/null)

[ -z "$url" ] && url="$paused_url"
[ -z "$url" ] && show_empty

key=$(printf '%s' "$url" | md5sum | cut -d' ' -f1)
existing=$(find "$CACHE" -maxdepth 1 -name "$key.*" -print -quit)
if [ -n "$existing" ]; then
    echo "$existing"
    exit 0
fi

tmp=$(mktemp "$CACHE/.tmp.XXXXXX")
trap 'rm -f "$tmp"' EXIT

case "$url" in
    file://*)
        path="${url#file://}"
        path=$(printf '%b' "${path//%/\\x}")
        cp -- "$path" "$tmp" 2>/dev/null || show_empty
        ;;
    http://*|https://*)
        curl -sfL --max-time 5 -o "$tmp" "$url" || show_empty
        ;;
    *)
        show_empty
        ;;
esac

case "$(file -b --mime-type "$tmp")" in
    image/png)  ext=png ;;
    image/jpeg) ext=jpg ;;
    image/webp) ext=webp ;;
    *)          show_empty ;;
esac

find "$CACHE" -maxdepth 1 -type f ! -name 'empty.png' ! -name '.tmp.*' -delete

mv "$tmp" "$CACHE/$key.$ext"
echo "$CACHE/$key.$ext"
