#!/bin/bash
# simple bluetooth phone detection tool.
# inspiration from github.com/vlachoudis/DetectPhone

BTHW='F8:5F:2A:04:A3:46'
SLEEP=10

while true
do
  l2ping -t 5 -c 1 $BTHW >/dev/null 2>/dev/null 
  RC=$?
  if [ $RC = 0 ]; then
    xautolock -disable
  else
    xautolock -locknow
  fi
  sleep $SLEEP
done
