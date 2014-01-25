#!/bin/sh
#
# small script for cleaning out webcache
#

rm -r $HOME/.mozilla/firefox
rm -r $HOME/.cache/mozilla/firefox
rm -r $HOME/.cache/webkitgtk/applications/*
