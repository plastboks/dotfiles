#!/bin/bash

if [ -z "$2" ]
then
    echo "Usage: $0 <diskimage.raw> <memsize>"
    exit 1
fi

/usr/bin/qemu-system-x86_64 \
    -boot c \
    -m $2 \
    -hda $1 \
    -name $1 \
    -net nic,vlan=0 \
    -net user,vlan=0 \
    -enable-kvm \
    -redir tcp:2222::22 \
    -vnc :1 \
    -localtime &

# -curses \
# -cpu kvm64 \
# -machine pc-i440fx-2.3 \
