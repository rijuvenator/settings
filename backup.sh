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
echo "Copying from cmslpc; running kinit; you'll be asked for your password."
kinit adasgupt@FNAL.GOV
scp adasgupt@cmslpc-sl6.fnal.gov:~/".tcshrc .bashrc" ~/settings/
mv ~/settings/.tcshrc ~/settings/tcshrc_cmslpc.sh
mv ~/settings/.bashrc ~/settings/bashrc_cmslpc.sh
