#!/bin/bash

case $1 in
    mute)     swayosd-client --output-volume mute-toggle ;;
    up)       swayosd-client --output-volume raise ;;
    down)     swayosd-client --output-volume lower ;;
    mic-mute) swayosd-client --input-volume mute-toggle ;;
esac
