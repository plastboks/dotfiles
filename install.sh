#!/bin/bash

SCRIPT=`readlink -f $0`
DOTPATH=`dirname $SCRIPT`

VERSION="0.001"
DIRS=($HOME/.config $HOME/downloads)

LIST=(
    # core
    bin
    scripts
    includes
    gnupg
    fonts
    i3
    xinitrc
    Xresources
    Xkbmap
    conkyrc
    screenlayout

    # shell
    bash_profile
    bashrc
    zshrc
    zshenv
    zprofile
    oh-my-zsh
    hushlogin

    # media
    mplayer
    newsbeuter

    # various
    muttrc
    mailcap
    tmux.conf
    irssi
    gtkrc-2.0
    livestreamerrc
    dynamic-colors
    compton.conf

    # config
    config/luakit
    config/uzbl
    config/dwb
    config/vimb
    config/fontconfig
    config/user-dirs.dirs
    config/redshift.conf
    config/dunst
)

function createDirs() {
    for i in "${DIRS[@]}"
    do
        if [ -d $i ]; then
            printf "=> $i exists\n"
        else
            printf "=> Creating $i\n"
            mkdir $i
        fi
    done
}

function showList() {
    printf "=> Available files and dirs:\n\n"
    for elem in "${LIST[@]}"; do
        printf "\t$elem\n"
    done
    echo ""
}

function symlink() {
    remove $1
    printf "=> Symlinking $HOME/.$1\n"
    ln -s $DOTPATH/.$1 $HOME/.$1
}

function remove() {
    if [ -d "$HOME/.$1" -o -f "$HOME/.$1" ]; then
        printf "=> $HOME/.$1 exists. Deleting it\n"
        rm -r $HOME/.$1
    fi
}

function symlinkAll() {
    printf "=> Symlinking everthing:\n"
    for elem in "${LIST[@]}"; do
        symlink $elem
    done
}

function removeAll() {
    printf "=> Deleting everthing:\n"
    for elem in "${LIST[@]}"; do
        remove $elem
    done
}

function findAndInstall() {
    for elem in "${LIST[@]}"; do
        if [ $1 = $elem ]; then
            symlink $elem
            exit
        fi
    done
    printf "=> Unknown dotfile - $1\n"
}

function findAndRemove() {
    for elem in "${LIST[@]}"; do
        if [ $1 = $elem ]; then
            remove $elem
            exit
        fi
    done
    printf "=> Unknown dotfile - $1\n"
}

function showHelp() {
    printf "Usage: $0 <option>\n"
    cat<<EOF

Deploy script for my dotfiles - v:$VERSION

    --all                   Install everything in its right place
    --cdir                  Create directories
    --list                  List all available config files/dirs
    --install=<name>        Symlink only spesific file/dir
    --uninstall
    --remove=<name>
    --version               Show version.
    --help                  Show this...

EOF
}

while test $# -gt 0; do
    OPT=$1
    shift

    case "$OPT" in
        --all)
            createDirs
            symlinkAll
            exit
            ;;
        --uninstall)
            removeAll
            exit
            ;;
        --cdir)
            createDirs
            exit
            ;;
        --list)
            showList
            exit
            ;;
        --install=*)
            findAndInstall $(echo $OPT | sed 's/--install=//')
            exit
            ;;
        --remove=*)
            findAndRemove $(echo $OPT | sed 's/--install=//')
            exit
            ;;
        --version)
            printf "=> Version: $VERSION\n"
            exit
            ;;
        --help)
            showHelp
            exit
            ;;
        *)
            printf "=> Unrecognized option $1\n"
            exit
            ;;
    esac
done

if [ "x$1" = "x" ]; then
    showHelp
fi

exit
