#!/bin/bash
mkdir -p ~/dotfiles/scripts
cp ~/Documents/scripts/* ~/dotfiles/scripts/
cd ~/dotfiles
git add -A
git commit -m "new dotfiles"
git push