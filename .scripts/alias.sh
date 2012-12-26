# some nice aliases


alias backup-mount='sshfs $user@$server: $path -o uid=$(id -u) -o gid=$(id -g)'
alias pdfmerge='gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=./output.pdf'
