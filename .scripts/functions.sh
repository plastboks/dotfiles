# some nice aliases


function backup_mount() {
  sshfs "$*@$*: $* -o uid=$(id -u) -o gid=$(id -g)"
}


function pdfmerge() {
  gs "-dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=./$@ $*"
}
