#!/bin/bash

case $1 in
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
            MSG="Muted"
        else
            MSG=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d%%", $2 * 100}')
        fi
        notify-send -t 1500 -h string:x-canonical-private-synchronous:volume "Volume" "$MSG"
        ;;
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        MSG=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d%%", $2 * 100}')
        notify-send -t 1500 -h string:x-canonical-private-synchronous:volume "Volume" "$MSG"
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        MSG=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d%%", $2 * 100}')
        notify-send -t 1500 -h string:x-canonical-private-synchronous:volume "Volume" "$MSG"
        ;;
    mic-mute)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then
            MSG="Muted"
        else
            MSG="Active"
        fi
        notify-send -t 1500 -h string:x-canonical-private-synchronous:mic "Microphone" "$MSG"
        ;;
esac
