#!/bin/bash

MOVIE=`quvi dump $1 | grep QUVI_MEDIA_STREAM_PROPERTY_URL= | sed -n 's/[^=]*\=//p'` && mplayer $MOVIE

exit 1
