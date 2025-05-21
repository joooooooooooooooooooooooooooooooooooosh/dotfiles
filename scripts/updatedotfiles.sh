#!/bin/bash
DOT_DIR="$HOME/.dotfiles/"
CONFIG_DIR=$DOT_DIR"config/"

cp ~/.nvimrc "${DOT_DIR}vim/"
cp ~/.zshrc "${DOT_DIR}shell"
cp ~/.zshenv "${DOT_DIR}shell"
cp ~/.bashrc "${DOT_DIR}shell"
cp ~/.aliases "${DOT_DIR}shell"
cp ~/.bookmarks "${DOT_DIR}shell"
cp ~/.gitconfig "$DOT_DIR"
cp ~/.gdbinit "$DOT_DIR"
cp ~/.config/alacritty/alacritty.toml "${CONFIG_DIR}alacritty/"
cp ~/.config/aerospace/aerospace.toml "${CONFIG_DIR}aerospace/"
rm -r "${CONFIG_DIR}nvim/"
cp -r ~/.config/nvim "${CONFIG_DIR}nvim/"
rm -rf "${CONFIG_DIR}ranger/"
cp -r ~/.config/ranger "${CONFIG_DIR}ranger/"
rm -r "${CONFIG_DIR}sketchybar/"
cp -r ~/.config/sketchybar "${CONFIG_DIR}sketchybar/"
rm -r "${DOT_DIR}vim/skeletons/"
cp -r ~/.vim/skeletons "${DOT_DIR}vim/"
rm -r "${DOT_DIR}macos_scripts"
cp -r ~/scripts "${DOT_DIR}macos_scripts"
rm -r "${DOT_DIR}espanso"
cp -r ~/Library/Application\ Support/espanso "${DOT_DIR}espanso/"
rm -r "${DOT_DIR}keybindings"
cp -r ~/Library/KeyBindings "${DOT_DIR}keybindings/"

cur_theme=$(grep "^ZSH_THEME" "${DOT_DIR}shell/.zshrc" | cut -d\" -f2)
[ "$cur_theme" != "random" ] && cp "$HOME/.oh-my-zsh/themes/$cur_theme.zsh-theme" "${DOT_DIR}shell/current.zsh-theme"

if ! { [ $# -ge 1 ] && [ "$1" == "-n" ]; }; then
    cd "$DOT_DIR" || {
        echo "cd ${DOT_DIR} failed"
        exit 1
    }
    if [ "$1" == "-d" ]; then
        git diff
    else
        git add -i
        read -rp "Commit message: " msg
        git commit -m "$msg"
        git push
    fi
fi
