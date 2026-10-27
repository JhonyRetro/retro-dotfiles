#!/usr/bin/env bash

LOW="${BATTERY_LOW:-20}"
CRITICAL="${BATTERY_CRITICAL:-10}"
SHUTDOWN="${BATTERY_SHUTDOWN:-5}"
COUNTDOWN="${BATTERY_COUNTDOWN:-60}" 
INTERVAL="${BATTERY_INTERVAL:-60}" 
NOTIFY_AC="${BATTERY_NOTIFY_AC:-1}"
PS_DIR="/sys/class/power_supply"

BAT=""
for b in "$PS_DIR"/BAT*; do
    [ -e "$b/capacity" ] && BAT="$b" && break
done
[ -z "$BAT" ] && exit 0

AC=""
for p in "$PS_DIR"/*; do
    [ "$(cat "$p/type" 2>/dev/null)" = "Mains" ] && AC="$p" && break
done

exec 9>"${XDG_RUNTIME_DIR:-/tmp}/battery-notify.lock"
flock -n 9 || exit 0

notify() {
    notify-send -a "Battery" "$@"
}

on_ac() {
    if [ -n "$AC" ]; then
        [ "$(<"$AC/online")" = "1" ]
    else
        [ "$(<"$BAT/status")" != "Discharging" ]
    fi
}

ac_state() {
    on_ac && echo 1 || echo 0
}

shutdown_countdown() {
    local id remaining
    id=$(notify -p -u critical -i battery-empty -h int:value:100 \
        "Shutting down in ${COUNTDOWN} s" \
        "Battery level at $(<"$BAT/capacity")%. Please connect your charger.")

    for (( remaining = COUNTDOWN; remaining > 0; remaining-- )); do
        if on_ac; then
            notify -r "$id" -u normal -i battery-good-charging \
                "Charger connected."
            return 1
        fi
        notify -r "$id" -u critical -i battery-empty \
            -h int:value:$(( remaining * 100 / COUNTDOWN )) \	
            "Shutting down in ${remaining} s" \
            "Battery level at $(<"$BAT/capacity")%. Please connect your charger."
        sleep 1
    done
    systemctl poweroff
}

coproc UDEV { exec stdbuf -oL udevadm monitor --udev --subsystem-match=power_supply 2>/dev/null; }
trap 'kill "$UDEV_PID" 2>/dev/null' EXIT

wait_for_event() {
    local rc
    read -r -t "$INTERVAL" -u "${UDEV[0]}" _ 2>/dev/null
    rc=$?
    if [ "$rc" -ne 0 ] && [ "$rc" -le 128 ]; then
        sleep "$INTERVAL"
    fi
}

# notified: 0 = no warning, 1 = low battery warning, 2 = critical battery warning
notified=0
prev_ac=$(ac_state)   
ac_id=""             

while true; do
    [ -S "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}" ] || exit 0

    capacity=$(<"$BAT/capacity")
    status=$(<"$BAT/status")
    now_ac=$(ac_state)

    if [ "$NOTIFY_AC" = "1" ] && [ "$now_ac" != "$prev_ac" ]; then
        replace=()
        [ -n "$ac_id" ] && replace=(-r "$ac_id")
        if [ "$now_ac" = "1" ]; then
            ac_id=$(notify -p "${replace[@]}" -u low -i battery-good-charging \
                "Charger connected" "Battery level at ${capacity}%.")
        else
            ac_id=$(notify -p "${replace[@]}" -u low -i battery-good \
                "Charger disconnected" "Battery level at ${capacity}%.")
        fi
    fi
    prev_ac=$now_ac

    if [ "$status" = "Discharging" ]; then
        if [ "$capacity" -le "$SHUTDOWN" ]; then
            shutdown_countdown
            prev_ac=$(ac_state)
        elif [ "$capacity" -le "$CRITICAL" ] && [ "$notified" -lt 2 ]; then
            notify -u critical -i battery-caution \
                "Critical battery level: ${capacity}%" \
                "System will shutdown at ${SHUTDOWN}%. Please connect your charger."
            notified=2
        elif [ "$capacity" -le "$LOW" ] && [ "$notified" -lt 1 ]; then
            notify -u normal -i battery-low \
                "Low battery level: ${capacity}%" \
                "A charger may be plugged in."
            notified=1
        fi
    else
        notified=0
    fi

    wait_for_event
done
