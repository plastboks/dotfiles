#!/bin/sh

if [ -z "$2" ]; then
    echo "Usage: xbacklight <key> <value>"
    exit 1
fi

xbacklight $1 $2
echo `xbacklight -get` > ~/.backlight
