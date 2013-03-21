#!/bin/sh
#
# small script for printing email from putt to pdf.
#

PDIR="$HOME/downloads"

tmpfile="`mktemp $PDIR/mutt_XXXXXXXX.pdf`"
enscript --font=Courier8 $1 -G2r -p - 2>/dev/null | ps2pdf - $tmpfile
