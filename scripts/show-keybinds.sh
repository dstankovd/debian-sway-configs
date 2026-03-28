#!/bin/bash

# ANSI colors (uses terminal palette — auto-matches active theme)
ACCENT='\e[33m'
BOLD='\e[1;37m'
DIM='\e[2;37m'
RESET='\e[0m'

section() { printf "\n  ${ACCENT}%s${RESET}\n\n" "$1"; }
row()     { printf "  ${BOLD}%-32s${RESET}  ${DIM}%s${RESET}\n" "$1" "$2"; }
sep()     { printf "  ${DIM}──────────────────────────────────────────${RESET}\n"; }

{
    printf "\n"
    printf "  ${BOLD}KEYBINDINGS${RESET}\n"
    sep

    section "BASICS"
    row "Super + Enter"              "Terminal"
    row "Super + W"                  "Close window"
    row "Super + D"                  "App launcher"
    row "Super + L"                  "Lock screen"
    row "Super + ?"                  "This screen"
    row "Super + Shift + T"          "Change theme"
    row "Super + Shift + C"          "Reload config"
    row "Super + Shift + Esc"        "Power menu"
    row "Super + Shift + E"          "Exit sway"

    section "FOCUS"
    row "Super + H / J / K / L"     "Focus left / down / up / right"
    row "Super + Arrows"             "Focus left / down / up / right"

    section "MOVE WINDOW"
    row "Super + Shift + H/J/K/L"   "Move left / down / up / right"
    row "Super + Shift + Arrows"     "Move left / down / up / right"

    section "WORKSPACES"
    row "Super + 1 … 0"              "Switch to workspace 1–10"
    row "Super + Shift + 1 … 0"      "Move window to workspace 1–10"

    section "LAYOUT"
    row "Super + B"                  "Split horizontal"
    row "Super + V"                  "Split vertical"
    row "Super + S"                  "Stacking layout"
    row "Super + T"                  "Tabbed layout"
    row "Super + E"                  "Toggle split"
    row "Super + F"                  "Fullscreen"
    row "Super + Shift + Space"      "Float / tile toggle"
    row "Super + Space"              "Focus mode toggle"
    row "Super + A"                  "Focus parent container"

    section "SCRATCHPAD"
    row "Super + Shift + -"          "Send window to scratchpad"
    row "Super + -"                  "Show scratchpad"

    section "RESIZE MODE  (Super + R to enter)"
    row "H / J / K / L"              "Shrink / grow width or height"
    row "Arrows"                      "Shrink / grow width or height"
    row "Enter / Escape"              "Exit resize mode"

    section "MEDIA KEYS"
    row "Mute"                        "Toggle audio mute"
    row "Volume Down / Up"            "Decrease / increase volume"
    row "Mic Mute"                    "Toggle microphone"
    row "Brightness Down / Up"        "Decrease / increase brightness"

    section "SCREENSHOTS"
    row "Print"                       "Full screenshot  →  ~/Pictures/Screenshots/"
    row "Super + Print"               "Selection  →  annotate & save (swappy)"
    row "Super + Shift + Print"       "Selection  →  clipboard"

    printf "\n  ${DIM}Press q or Escape to close${RESET}\n\n"

} | LESS="-R --quit-if-one-screen" less
