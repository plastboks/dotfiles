#!/bin/sh
#
# usage example: `sh webmplayer.sh {medium|good|best} URL`

MOVIE=$(quvi dump -s $1 $2 | grep QUVI_MEDIA_STREAM_PROPERTY_URL= | sed -n 's/[^=]*\=//p') && mplayer $MOVIE

#quvi dump -s medium -e "mplayer %u" $1

