#!/bin/bash

REPO="$(cd "$(dirname "$(readlink -f "$0")")/../.." && pwd)"
THEMES_DIR="$REPO/themes"

# ANSI colors (uses terminal palette — auto-matches active theme)
YELLOW='\e[33m'
BOLD_YELLOW='\e[1;33m'
DIM='\e[2;37m'
BOLD='\e[1;37m'
RESET='\e[0m'

# Collect themes (exclude 'active' symlink)
themes=()
for d in "$THEMES_DIR"/*/; do
    name="$(basename "$d")"
    [ "$name" = "active" ] && continue
    themes+=("$name")
done

# Detect current active theme
current="$(basename "$(readlink "$THEMES_DIR/active")")"

# Start cursor on the active theme
selected=0
for i in "${!themes[@]}"; do
    [ "${themes[$i]}" = "$current" ] && selected=$i && break
done

draw() {
    clear
    printf "\n"
    for i in "${!themes[@]}"; do
        local name="${themes[$i]}"
        local is_active=false
        local is_cursor=false
        [ "$name" = "$current" ]    && is_active=true
        [ "$i"    = "$selected" ]   && is_cursor=true

        if $is_cursor && $is_active; then
            printf "  ${BOLD_YELLOW}→ ${name} ●${RESET}\n"
        elif $is_cursor; then
            printf "  ${BOLD}→ ${name}${RESET}\n"
        elif $is_active; then
            printf "    ${YELLOW}${name} ●${RESET}\n"
        else
            printf "    ${DIM}${name}${RESET}\n"
        fi
    done
    printf "\n"
}

# Hide cursor while picker is open
tput civis
trap 'tput cnorm; clear' EXIT

draw

KEY=""
while true; do
    IFS= read -r -s -n1 KEY
    if [[ "$KEY" == $'\x1b' ]]; then
        read -r -s -n2 -t 0.1 rest
        KEY="${KEY}${rest}"
    fi

    case "$KEY" in
        $'\x1b[A')  # Up
            (( selected > 0 )) && (( selected-- ))
            draw
            ;;
        $'\x1b[B')  # Down
            (( selected < ${#themes[@]} - 1 )) && (( selected++ ))
            draw
            ;;
        ""|$'\n'|$'\r')  # Enter
            selected_theme="${themes[$selected]}"
            tput cnorm
            clear
            if [ "$selected_theme" != "$current" ]; then
                echo "Applying: $selected_theme"
                "$REPO/configs/scripts/switch-theme.sh" "$selected_theme"
            fi
            exit 0
            ;;
        $'\x1b')  # Escape
            exit 0
            ;;
    esac
done
