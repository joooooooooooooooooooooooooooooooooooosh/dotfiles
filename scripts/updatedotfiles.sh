#!/bin/bash
DOT_DIR="$HOME/.dotfiles/"

rm -r $DOT_DIR"polybar/"
cp -ur ~/.config/polybar $DOT_DIR
rm -r $DOT_DIR"scripts/"
cp -ur ~/Documents/scripts $DOT_DIR
rm -r $DOT_DIR"polybar-scripts/"
cp -ur ~/polybar-scripts $DOT_DIR
cp -u ~/.vimrc $DOT_DIR"vim/"
cp -u ~/.nvimrc $DOT_DIR"vim/"
cp -u ~/.vim/plugged/wal.vim/colors/wal.vim $DOT_DIR"vim/"
cp -u ~/.zshrc $DOT_DIR
cp -u ~/.bashrc $DOT_DIR
cp -u ~/.Xresources $DOT_DIR
cp -u ~/.gitconfig $DOT_DIR
cp -u ~/.gdbinit $DOT_DIR
cp -u /etc/xdg/picom.conf $DOT_DIR
cp -u ~/.config/fusuma/config.yml $DOT_DIR"fusuma/"
cp -u ~/.config/i3/config $DOT_DIR"i3/"
cp -u ~/.config/spicetify/config.ini $DOT_DIR"spicetify/"
cp -u ~/.config/alacritty/alacritty.yml $DOT_DIR
rm -r $DOT_DIR"ranger/"
cp -ur ~/.config/ranger $DOT_DIR"ranger/"
rm -r $DOT_DIR"rofi/"
cp -ur ~/.config/rofi $DOT_DIR
rm -r $DOT_DIR"skeletons/"
cp -ur ~/.vim/skeletons $DOT_DIR

cur_theme=`cat $DOT_DIR".zshrc" | grep ^ZSH_THEME | cut -d\" -f2`

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
