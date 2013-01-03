#!/bin/bash
#
# This script was yanked from archlinux forum post 101413.
# Thanks to user Foucault for supplying it.
# 
# Example usage is: for file in *.flac; do flac2ogg.sh "$i" QUALITY; done
# Quality is typical 6 for CDs, (Higher is better).
#
# Archlinux package vorbis-tools is needed for oggenc.
#

file=${1/.flac/}
qual=$2
echo "File: $file.flac"
echo "Quality: $qual"
title=`metaflac --show-tag="title" "$file.flac" | sed "s/title=//"`
artist=`metaflac --show-tag="artist" "$file.flac" | sed "s/artist=//"`
album=`metaflac --show-tag="album" "$file.flac" | sed "s/album=//"`
date=`metaflac --show-tag="date" "$file.flac" | sed "s/date=//"`
genre=`metaflac --show-tag="genre" "$file.flac" | sed "s/genre=//"`
track=`metaflac --show-tag="tracknumber" "$file.flac" | sed "s/tracknumber=//"`

flac -c -d "$file.flac" | oggenc -t "$title" -a "$artist" -G "$genre" -l "$album" \
 -d "$date" -n "$track" -o $file.ogg -q $qual -

