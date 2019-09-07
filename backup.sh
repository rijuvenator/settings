#!/bin/bash
# Backup Mac
echo -e "\n\033[1mBacking up local Mac: .vim .bashmodules .vimrc .bash_profile\033[m"
rm -r ~/settings/vim_mac/ ~/settings/bashmodules
cp -r ~/.bashmodules ~/settings/bashmodules
cp -r ~/.vim ~/settings/vim_mac
cp ~/.vimrc ~/settings/vimrc_mac.vim
cp ~/.bash_profile ~/settings/bash_profile_mac.sh
cp ~/.inputrc ~/settings/inputrc_mac
