#!/bin/bash

sudo pacman -S -noconfim lib32-libcups rpmextract

mkdir ~/.brother
cd ~/.brother

wget -nc http://pub.brother.com/pub/com/bsc/linux/dlf/cupswrapperHL2270DW-2.0.4-2.i386.rpm
wget -nc http://www.brother.com/pub/bsc/linux/dlf/hl2270dwlpr-2.1.0-1.i386.rpm
rpmextract.sh hl2270dwlpr-2.1.0-1.i386.rpm
rpmextract.sh cupswrapperHL2270DW-2.0.4-2.i386.rpm

sed -i "s|/etc/init.d/|/etc/rc.d/|g" usr/local/Brother/Printer/HL2270DW/cupswrapper/cupswrapperHL2270DW-2.0.4 
sed -i "s|/cupsys|/cupsd|g" usr/local/Brother/Printer/HL2270DW/cupswrapper/cupswrapperHL2270DW-2.0.4 

sudo cp -r usr/* /usr

sudo /usr/local/Brother/Printer/HL2270DW/cupswrapper/cupswrapperHL2270DW-2.0.4 
