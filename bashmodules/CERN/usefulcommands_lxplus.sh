source ~/.bashmodules/usefulcommands_common.sh

# Sets grep colors: filename to faint, matching text to bright bold red, matching lines to bold, and line numbers and separators to green
# ggrep puts matching lines on their own indented line, and takes out the colon
export GREP_COLORS="fn=2:ms=1;91:mc=1;91:mt=1;91:cx=1:sl=1:ln=32:bn=32:se=32"
function ggrep
{
	sed -n "s/:/\n    /p" <(2>/dev/null grep --color=always "$@")
}

# File Count: recursively determine how many files are in each directory
function fc
{
	f=($(find . -type d))
	maxlen="5"
	declare -A fc
	for x in "${f[@]}"
	do
		c=$(find $x -maxdepth 1 -type f | wc -l)
		if [ $c != 0 ]
		then
			fc[$x]=$c
			l=$(echo $x | wc -c)
			l=$(echo $l | sed 's/^[ \t]*//')
			if [ $l -gt $maxlen ]
			then
				maxlen=$l
			fi
		fi
	done
	for x in "${!fc[@]}"
	do
		printf "%-"$maxlen"s %i\n" $x ${fc[$x]}
	done
	printf "%-"$maxlen"s %i\n" "TOTAL" $(echo "${fc[@]}" | awk 'BEGIN {RS=" "; c=0} {c+=$0} END {print c}')
}

# evince without error
function evince ()
{
	/usr/bin/evince $1 2>&1 | grep -v "Failed to create dbus proxy";
}

# start ssh-agent, add ssh private key; must be done once per shell
alias sshsetup='eval `ssh-agent -s`; ssh-add'

# condor_q aliases
alias cq='condor_q'
alias cqa='condor_q -format "%s\n" Args'
alias cstat='condor_status -sched'
function cset ()
{
    if [[ "$1" =~ ^[01][0-9]$ ]]
    then
        for s in CR SCH
        do
            export _condor_${s}EDD_HOST="bigbird$1.cern.ch"
        done
        return 0
    else
        echo "Need a new scheduler, run cstat first"
        return 1
    fi
}
