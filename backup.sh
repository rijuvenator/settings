#!/bin/bash

cp ~/.vimrc ~/settings/vimrc_mac
cp ~/.bash_profile ~/settings/bash_profile_mac
rm -r ~/settings/vim_mac/
cp -r ~/.vim ~/settings/vim_mac
echo "Copying from lxplus; you'll be asked for your password."
scp adasgupt@lxplus.cern.ch:~/".bash_profile .vimrc" ~/settings/
mv .bash_profile bash_profile_lxplus
mv .vimrc vimrc_lxplus
