#!/bin/bash

pdfmerge() {
  gs "-dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=./$@ $*"
}


ssh-add-all() {
  eval `ssh-agent`
  for file in `ls $HOME/.ssh/id_* | grep -v .pub`; do
    ssh-add $file
  done
}

sshrfs() {
  ssh-add-all
  sshfs -o workaround=rename -o uid=$(id -u) -o gid=$(id -g) $1: $2
}


