#!/bin/sh

while true; do
  MAILBOX=`inotifywait ~/.mutt/cache/headers 2> /dev/null`
  notify-send -t 15000 "New mail"
  sleep 10
done
