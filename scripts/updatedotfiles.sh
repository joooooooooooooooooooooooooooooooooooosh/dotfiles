#!/bin/bash
DOT_DIR="$HOME/.dotfiles/"

cp -ur ~/.config/polybar/* $DOT_DIR"polybar/"
cp -u ~/Documents/scripts/* $DOT_DIR"scripts/"
cp -u ~/polybar-scripts/* $DOT_DIR"polybar-scripts/"
cp -u ~/.zshrc $DOT_DIR
cp -u ~/.bashrc $DOT_DIR
cp -u ~/.vimrc $DOT_DIR
cp -u ~/.nvimrc $DOT_DIR
cp -u ~/.vim/plugged/wal.vim/colors/wal.vim $DOT_DIR
cp -u ~/.Xresources $DOT_DIR
cp -u ~/.gitconfig $DOT_DIR
cp -u ~/.gdbinit $DOT_DIR
cp -u /etc/xdg/picom.conf $DOT_DIR
cp -u ~/.config/fusuma/config.yml $DOT_DIR"fusuma/"
cp -u ~/.config/i3/config $DOT_DIR"i3/"
cp -u ~/.config/spicetify/config.ini $DOT_DIR"spicetify/"
cp -u ~/.config/termite/* $DOT_DIR"termite/"
cp -u ~/.config/alacritty/alacritty.yml $DOT_DIR
cp -u ~/.config/ranger/* $DOT_DIR"ranger/"

cur_theme=`cat $DOT_DIR".zshrc" | grep ^ZSH_THEME | sed 's/.*"\(.*\)".*/\1/'`

[ "$cur_theme" != "random" ] && cp "$HOME/.oh-my-zsh/themes/$cur_theme.zsh-theme" $DOT_DIR"current.zsh-theme"

if ! [ $# -ge 1 -a "$1" == "-n" ]; then
    cd $DOT_DIR
    if [ "$1" == "-d" ]; then
        git diff
    else
        git add -A
        git commit -m "new dotfiles"
        git push
    fi
fi
