#### CERN Aliases ####
# CMSENV is the "real" cmsenv
# cmsset gives access to scram and cmsrel
# crabenv gives access to crab
# voms initializes voms proxy
alias CMSENV='eval `scramv1 runtime -sh`'
alias cmsset='source /cvmfs/cms.cern.ch/cmsset_default.sh'
alias crabenv='source /cvmfs/cms.cern.ch/crab3/crab.sh'
alias voms='voms-proxy-init -voms cms'

# EOS directories
export EOS="eos/cms/store/user/adasgupt"
export EOSROOT="root://eoscms//eos/cms/store/user/adasgupt"
export EOSSRM="srm://srm-eoscms.cern.ch//eos/cms/store/user/adasgupt"
export EOSC="eos/cms/store/user/cschnaib"

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

# Logon history
sed -i "1a $(printf "%-10s --- %s\n" ${HOSTNAME%%.*} "`date +"%b %d %Y, %T %Z"`")" ~/logons
sed -ni "1,101p" ~/logons
