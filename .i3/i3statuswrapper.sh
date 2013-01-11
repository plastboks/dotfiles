#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
do
  read line
  CURLAYOUT=`xset -q | grep -A 0 'LED' | cut -c59-67`
  if [ $CURLAYOUT = "00000000" ]; then
    CURLAYOUT="US"
  fi
  if [ $CURLAYOUT = "00001004" ]; then
    CURLAYOUT="NO"
  fi
  echo "Layout: ${CURLAYOUT} | $line" || exit 1
done
