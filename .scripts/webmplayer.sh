#!/bin/sh

MOVIE=$(quvi dump -s good $1 | grep QUVI_MEDIA_STREAM_PROPERTY_URL= | sed -n 's/[^=]*\=//p') && mplayer $MOVIE

#quvi dump -s medium -e "mplayer %u" $1

