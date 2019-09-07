source ~/.bashmodules/tabtitles_common.sh

# Sets Terminal titles; -t for tab, -w for window
function sett
{
	if [ "$1" == "-t" ]; then
		printf "\e]1;(${HOSTNAME%%.*}): $2\a"
	fi
	if [ "$1" == "-w" ]; then
		printf "\e]2;$2\a"
	fi
}

# Sets Terminal tab title to "root", then calls root
alias root='sett -t root; root'
