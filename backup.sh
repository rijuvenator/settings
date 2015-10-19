#!/bin/bash

cp ~/.vimrc ~/settings/vimrc_mac.vim
cp ~/.bash_profile ~/settings/bash_profile_mac.sh
rm -r ~/settings/vim_mac/
cp -r ~/.vim ~/settings/vim_mac
echo "Copying from lxplus; you'll be asked for your password."
scp adasgupt@lxplus.cern.ch:~/".bash_profile .vimrc .rootlogon.C colors.sh" ~/settings/
mv ~/settings/.bash_profile ~/settings/bash_profile_lxplus.sh
mv ~/settings/.vimrc ~/settings/vimrc_lxplus.vim
mv ~/settings/.rootlogon.C ~/settings/rootlogon.C
