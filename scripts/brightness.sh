#!/bin/bash

case $1 in
    up)   swayosd-client --brightness raise ;;
    down) swayosd-client --brightness lower ;;
esac
