#!/bin/sh

PATH="/mnt/external/sync/"

rsync -avz \
    --exclude=".Android*" \
    --exclude=".android" \
    --exclude=".Genymobile*" \
    --exclude=".gradle" \
    --exclude=".wine" \
    --exclude=".local/share/Steam" \
    --exclude=".cabal" \
    --exclude=".Idea*" \
    --exclude=".DataGrip*" \
    --exclude=".CLion*"
    --exclude=".IntelliJ*" \
    --exclude=".Web*" \
    --include=".**" \
    --exclude="*" \
    ~/ $PATH
