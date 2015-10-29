#!/bin/bash
#
# android backup script
#

[ $# -eq 0 ] && { echo "Usage: $0 path"; exit 1; }
[ ! -d "$1" ] && { echo "'$1' is not a valid path"; exit 1; }

DATE=`date "+%Y-%m-%d.%s"`
BACKUPDIR="android-backup.$DATE"

LIST=(
    Alarms
    Android
    DCIM
    Movies
    Music
    Notifications
    Podcasts
    Ringtones
)

mkdir $BACKUPDIR

for elem in "${LIST[@]}"; do
    adb pull /sdcard/$elem $BACKUPDIR
done

tar cvzf $BACKUPDIR.tar.gz $BACKUPDIR
rm -r $BACKUPDIR
