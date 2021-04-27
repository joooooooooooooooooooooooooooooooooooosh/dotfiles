#!/bin/bash
mkdir -p ~/dotfiles/scripts
cp -u ~/Documents/scripts/* ~/dotfiles/scripts/
cp -u ~/polybar-scripts/* ~/dotfiles/polybar-scripts/
cp -u ~/.zshrc ~/dotfiles/
cp -u ~/.bashrc ~/dotfiles/
cp -u ~/.vimrc ~/dotfiles/
cp -u ~/.Xresources ~/dotfiles/
cp -u ~/.gitconfig ~/dotfiles/
cp -u ~/.gdbinit ~/dotfiles/
cp -u /etc/xdg/picom.conf ~/dotfiles/
cp -u ~/.config/fusuma/config.yml ~/dotfiles/fusuma/
cp -u ~/.config/polybar/* ~/dotfiles/polybar/
cp -u ~/.config/i3/config ~/dotfiles/i3/
cp -u ~/.config/rofi/* ~/dotfiles/rofi/
cp -u ~/.config/spicetify/config.ini ~/dotfiles/spicetify/
cp -u ~/.config/termite/* ~/dotfiles/termite/
cd ~/dotfiles
git add -A
git commit -m "new dotfiles"
git push