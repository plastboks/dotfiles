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
    -machine pc-i440fx-2.3 \
    -redir tcp:2222::22 \
    -redir tcp:9090::9090 \
    -redir tcp:9091::9091 \
    -vnc :1 \
    -localtime &

#-curses \
#-cpu kvm64 \
