#!/bin/bash
DOT_DIR="$HOME/.dotfiles/"
CONFIG_DIR=$DOT_DIR"config/"

<<<<<<< HEAD
rm -r "${CONFIG_DIR}polybar/"
cp -r ~/.config/polybar "${CONFIG_DIR}polybar/"
rm -r "${DOT_DIR}scripts/"
cp -r ~/Documents/scripts "$DOT_DIR"
cp ~/.vimrc "${DOT_DIR}vim/"
cp ~/.nvimrc "${DOT_DIR}vim/"
cp ~/.vim/plugged/wal.vim/colors/wal.vim "${DOT_DIR}vim/"
cp ~/.zshrc "$DOT_DIR"
cp ~/.bashrc "$DOT_DIR"
cp ~/.Xresources "$DOT_DIR"
cp ~/.gitconfig "$DOT_DIR"
cp ~/.gdbinit "$DOT_DIR"
cp /etc/xdg/picom.conf "$DOT_DIR"
cp ~/.config/fusuma/config.yml "${CONFIG_DIR}fusuma/"
cp ~/.config/i3/config "${CONFIG_DIR}i3/"
cp ~/.config/spicetify/config-xpui.ini "${CONFIG_DIR}spicetify/"
cp -r ~/.config/spicetify/Themes/WalSleek "${CONFIG_DIR}spicetify/Themes/"
cp  ~/.config/alacritty/alacritty.yml "${CONFIG_DIR}alacritty/"
=======
rm -rf "${CONFIG_DIR}polybar/"
cp -ur ~/.config/polybar "${CONFIG_DIR}polybar/"
rm -r "${DOT_DIR}scripts/"
cp -ur ~/Documents/scripts "$DOT_DIR"
cp -u ~/.vimrc "${DOT_DIR}vim/"
cp -u ~/.nvimrc "${DOT_DIR}vim/"
cp -u ~/.vim/plugged/wal.vim/colors/wal.vim "${DOT_DIR}vim/"
cp -u ~/.zshrc "${DOT_DIR}shell"
cp -u ~/.bashrc "${DOT_DIR}shell"
cp -u ~/.aliases "${DOT_DIR}shell"
cp -u ~/.Xresources "$DOT_DIR"
cp -u ~/.gitconfig "$DOT_DIR"
cp -u ~/.gdbinit "$DOT_DIR"
cp -u /etc/xdg/picom.conf "$DOT_DIR"
cp -u ~/.config/fusuma/config.yml "${CONFIG_DIR}fusuma/"
cp -u ~/.config/i3/config "${CONFIG_DIR}i3/"
cp -u ~/.config/spicetify/config-xpui.ini "${CONFIG_DIR}spicetify/"
cp -ur ~/.config/spicetify/Themes/WalSleek "${CONFIG_DIR}spicetify/Themes/"
cp -u ~/.config/alacritty/alacritty.yml "${CONFIG_DIR}alacritty/"
>>>>>>> master
rm -rf "${CONFIG_DIR}ranger/"
cp -r ~/.config/ranger "${CONFIG_DIR}ranger/"
rm -r "${CONFIG_DIR}rofi/"
cp -r ~/.config/rofi "${CONFIG_DIR}rofi/"
rm -r "${DOT_DIR}vim/skeletons/"
cp -r ~/.vim/skeletons "${DOT_DIR}vim/"
rm -r "${CONFIG_DIR}wal/"
cp -r ~/.config/wal "${CONFIG_DIR}wal/"
rm -rf "${DOT_DIR}wal-discord/"
cp -r ~/wal-discord "${DOT_DIR}wal-discord/"
cp /var/spool/cron/joshh "${DOT_DIR}"
cp /etc/udev/rules.d/80.power.rules "${DOT_DIR}"

cur_theme=$(grep "^ZSH_THEME" "${DOT_DIR}shell/.zshrc" | cut -d\" -f2)
[ "$cur_theme" != "random" ] && cp "$HOME/.oh-my-zsh/themes/$cur_theme.zsh-theme" "${DOT_DIR}shell/current.zsh-theme"

if ! { [ $# -ge 1 ] && [ "$1" == "-n" ]; }; then
    cd "$DOT_DIR" || { echo "cd ${DOT_DIR} failed"; exit 1; }
    if [ "$1" == "-d" ]; then
        git diff
    else
        git add -i
        read -rp "Commit message: " msg
        git commit -m "$msg"
        git push
    fi
fi
