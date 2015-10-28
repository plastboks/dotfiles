#!/bin/bash

if [ -z "$2" ]
then
    echo "Usage: $0 <install.iso> <diskimage.raw>"
    exit 1
fi

/usr/bin/qemu-system-x86_64 \
    -boot c \
    -m 2048 \
    -cdrom  $1 \
    -hda $2 \
    -enable-kvm \
    -net nic,vlan=0 \
    -net user,vlan=0 \
    -localtime &


#-machine pc-i440fx-2.3 \
