#!/bin/bash

cp ~/.vimrc ~/settings/.vimrc_mac
cp ~/.bash_profile ~/settings/.bash_profile_mac
scp adasgupt@lxplus.cern.ch:~/.bash_profile ~/settings/.bash_profile_lxplus
scp adasgupt@lxplus.cern.ch:~/.vimrc ~/settings/.vimrc_lxplus
