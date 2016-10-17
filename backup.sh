#!/bin/bash

function kkk
{
	FULL=$1
	NAME=${1%.*}
	if [ -a ~/.kcaches/cache_$NAME ]
	then
		cp ~/.kcaches/cache_$NAME ~/.kcaches/cache
	else
		kinit -c ~/.kcaches/cache_$NAME adasgupt@$FULL
		kkk $1
	fi
	datestr=$(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5"#"$6"#"$7"#"$8}')
	if [ $(date -j -f "%b#%d#%H:%M:%S#%Y" $datestr +%Y%m%d%H%M%S) -le $(date +%Y%m%d%H%M%S) ]
	then
		echo "Existing ticket expired; please re-authenticate."
		kinit -c ~/.kcaches/cache_$NAME adasgupt@$FULL
		kkk $1
	fi
}

cp ~/.vimrc ~/settings/vimrc_mac.vim
cp ~/.bash_profile ~/settings/bash_profile_mac.sh
rm -r ~/settings/vim_mac/
cp -r ~/.vim ~/settings/vim_mac
echo "Copying from lxplus; authentication may be required"
kkk CERN.CH
scp adasgupt@lxplus.cern.ch:~/".bashrc .vimrc .rootlogon.C scripts/colors" ~/settings/
mv ~/settings/.bashrc ~/settings/bashrc_lxplus.sh
mv ~/settings/.vimrc ~/settings/vimrc_lxplus.vim
mv ~/settings/.rootlogon.C ~/settings/rootlogon.C
echo "Copying from cmslpc; authentication may be required"
kkk FNAL.GOV
scp adasgupt@cmslpc-sl6.fnal.gov:~/".tcshrc .bashrc" ~/settings/
mv ~/settings/.tcshrc ~/settings/tcshrc_cmslpc.sh
mv ~/settings/.bashrc ~/settings/bashrc_cmslpc.sh
