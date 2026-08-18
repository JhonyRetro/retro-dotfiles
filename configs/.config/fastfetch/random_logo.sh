#!/bin/bash

LOGO_DIR="$HOME/.config/fastfetch/logo"

RANDOM_LOGO=$(find "$LOGO_DIR" -type f \( -iname \*.png \) | shuf -n 1)

fastfetch --logo-type kitty --logo "$RANDOM_LOGO"
