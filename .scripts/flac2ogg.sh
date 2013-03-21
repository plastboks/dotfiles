#!/bin/bash
#
# This script was yanked from archlinux forum post 101413.
# Thanks to user Foucault for supplying it.
# 
# Example script usage:
#   `flag2ogg.sh 'file' 'quality'`
#
# Example usage is for multiple files in a directory: 
#   `for file in *.flac; do flac2ogg.sh $file QUALITY; done`
#
# Quality is typical 6 for CDs, (Higher is better).
#
# Archlinux package vorbis-tools is needed for oggenc.
#

file=${1/.flac/}
qual=$2
echo "File: $file.flac"
echo "Quality: $qual"
title=`metaflac --show-tag="title" "$file.flac" | sed -e "s/title=//gI"`
artist=`metaflac --show-tag="artist" "$file.flac" | sed -e "s/artist=//gI"`
album=`metaflac --show-tag="album" "$file.flac" | sed -e "s/album=//gI"`
date=`metaflac --show-tag="date" "$file.flac" | sed -e "s/date=//gI"`
genre=`metaflac --show-tag="genre" "$file.flac" | sed -e "s/genre=//gI"`
track=`metaflac --show-tag="tracknumber" "$file.flac" | sed -e "s/tracknumber=//gI"`

flac -c -d "$file.flac" | oggenc -t "$title" -a "$artist" -G "$genre" -l "$album" \
 -d "$date" -n "$track" -o $file.ogg -q $qual -

