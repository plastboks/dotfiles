#!/bin/bash
#
# usage example: `for f in *.mp3; do ~/.scripts/mp32ogg.sh $f; done`

filename=$(basename "$1")
file="${filename%.*}"
echo "File: $file.mp3"

ARTIST=`eyeD3 "$file.mp3" | grep "artist" | sed -s 's/artist: //g'`
echo "Artist: "$ARTIST
TITLE=`eyeD3 "$file.mp3" | grep "title" | sed -s 's/title: //g'`
echo "Title: "$TITLE
GENRE=`eyeD3 "$file.mp3" | grep "genre" | grep "genre" | awk -F : '{print $NF}' | sed -e 's/^[ \t]*//'`
echo "Genre: "$GENRE
YEAR=`eyeD3 "$file.mp3" | grep "recording date" | sed -s 's/recording date: //g'`
echo "Year: "$YEAR
TRACK=`eyeD3 "$file.mp3" | grep "track" | awk '{print $2}'`
echo "Track: "$TRACK
LABEL=`eyeD3 "$file.mp3" | grep "album" | sed -s 's/title: //g'`
echo "Album: "$LABEL


lame --decode "$file.mp3" - | oggenc --resample 22050 -a "$ARTIST" -t "$TITLE" -l "$LABEL" -G "$GENRE" -d "$YEAR" -N "$TRACK" -o "$file.ogg" -

printf "\n"
exit
