#!/bin/bash

case $1 in
    up)   brightnessctl set 5%+ ;;
    down) brightnessctl set 5%- ;;
esac

BRI=$(brightnessctl | grep -oP '\d+(?=%)' | tail -1)
notify-send -t 1500 -h string:x-canonical-private-synchronous:brightness "Brightness" "${BRI}%"
