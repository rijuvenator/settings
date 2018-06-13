#!/bin/bash

function kauth
{
	FULL=$1
	NAME=${1%.*}
	if [ -a ~/.kcaches/cache_$NAME ]
	then
		cp ~/.kcaches/cache_$NAME ~/.kcaches/cache
	else
		kinit -c ~/.kcaches/cache_$NAME adasgupt@$FULL
		kauth $1
	fi
	if [ $(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5}') == ">>>Expired<<<" ]
	then
		echo "Existing ticket expired; please re-authenticate."
		kinit -c ~/.kcaches/cache_$NAME adasgupt@$FULL
		kauth $1
	fi
    if [ "$(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5$6$8}')" == "$(date "+%b%d%Y")" ]
    then
        echo "Warning: authentication will expire later today, please consider re-authenticating."
    fi
}

# Backup lxplus
echo -e "\033[1mBacking up lxplus; authentication may be required\033[m"
kauth CERN.CH
#scp adasgupt@lxplus.cern.ch:~/".bashrc .vimrc .rootlogon.C scripts/colors" ~/settings/
scp -S /usr/local/bin/ssh adasgupt@lxplus.cern.ch:~/".bashrc .vimrc .rootlogon.C scripts/colors" ~/settings/
mv ~/settings/.bashrc      ~/settings/bashrc_lxplus.sh
mv ~/settings/.vimrc       ~/settings/vimrc_lxplus.vim
mv ~/settings/.rootlogon.C ~/settings/rootlogon.C
mv ~/settings/colors       ~/settings/colors.sh

echo -e "\n\033[1mBacking up remote changes to .bashmodules\033[m"
rsync -vruc adasgupt@lxplus.cern.ch:~/.bashmodules/* ~/.bashmodules/

# Backup Mac
echo -e "\n\033[1mBacking up local Mac: .vim .bashmodules .vimrc .bash_profile\033[m"
rm -r ~/settings/vim_mac/ ~/settings/bashmodules
cp -r ~/.bashmodules ~/settings/bashmodules
cp -r ~/.vim ~/settings/vim_mac
cp ~/.vimrc ~/settings/vimrc_mac.vim
cp ~/.bash_profile ~/settings/bash_profile_mac.sh

# Backup cmslpc
echo -e "\n\033[1mCopying from cmslpc; authentication may be required\033[m"
kauth FNAL.GOV
#scp adasgupt@cmslpc-sl6.fnal.gov:~/".tcshrc .bashrc" ~/settings/
scp -S /usr/local/bin/ssh adasgupt@cmslpc-sl6.fnal.gov:~/".tcshrc .bashrc" ~/settings/
mv ~/settings/.tcshrc ~/settings/tcshrc_cmslpc.sh
mv ~/settings/.bashrc ~/settings/bashrc_cmslpc.sh
