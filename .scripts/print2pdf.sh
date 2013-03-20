#!/bin/sh

INPUT="$1"
PDIR="$HOME/downloads"

tmpfile="`mktemp $PDIR/mutt_XXXXXXXX.pdf`"
enscript --font=Courier8 $INPUT -G2r -p - 2>/dev/null | ps2pdf - $tmpfile
