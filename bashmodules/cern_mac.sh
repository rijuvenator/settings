source ~/.bashmodules/cern_common.sh

#### SSH FUNCTIONS ####
# krb5.conf expects the ticket to be in ~/.kcaches/cache, so the directory MUST exist
mkdir -p ~/.kcaches

# kcern and kfnal switch the "active" kerberos ticket to lxplus and cmslpc, check if it's expired, and re-authenticate if so
# sshcern and sshfnal ssh into lxplus and cmslpc; each will take a number string; if specified, ssh'ing into a specific machine will be attempted

# kreset: deletes old kerberos tickets
function kreset
{
	if [ $# == 0 ]; then
		kreset -c
		#kreset -f
	elif [ "$1" == "-c" ]; then
		rm -f ~/.kcaches/cache_CERN
	elif [ "$1" == "-f" ]; then
		rm -f ~/.kcaches/cache_FNAL
	fi
}

# lxplus remote logon
export CH="adasgupt@lxplus.cern.ch"
function kcern
{
	if [ -a ~/.kcaches/cache_CERN ]
	then
		cp ~/.kcaches/cache_CERN ~/.kcaches/cache
	else
		kinit -c ~/.kcaches/cache_CERN adasgupt@CERN.CH
		kcern
	fi
#	datestr=$(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5"#"$6"#"$7"#"$8}')
#	if [ $(date -j -f "%b#%d#%H:%M:%S#%Y" $datestr +%Y%m%d%H%M%S) -le $(date +%Y%m%d%H%M%S) ]
# As it turns out, my lovely date parsing function is not needed, because the damn ticket just prints Expired instead of a date.
	if [ $(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5}') == ">>>Expired<<<" ]
	then
		echo "Existing ticket expired; please re-authenticate."
		kinit -c ~/.kcaches/cache_CERN adasgupt@CERN.CH
		kcern
	fi
}
function sshcern
{
	kcern
	if [ $# == 0 ]; then
		ssh -Y adasgupt@lxplus.cern.ch
		return 0
	fi
	if [[ "$1" =~ [^0-9] ]]; then
		echo "Non-digit detected; check input string." >&2
		return 1
	fi
	ssh -Y adasgupt@lxplus${1}.cern.ch
}

# cmslpc remote logon
export FH="adasgupt@cmslpc-sl6.fnal.gov"
function kfnal
{
	if [ -a ~/.kcaches/cache_FNAL ]
	then
		cp ~/.kcaches/cache_FNAL ~/.kcaches/cache
	else
		kinit -c ~/.kcaches/cache_FNAL adasgupt@FNAL.GOV
		kfnal
	fi
#	datestr=$(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5"#"$6"#"$7"#"$8}')
#	if [ $(date -j -f "%b#%d#%H:%M:%S#%Y" $datestr +%Y%m%d%H%M%S) -le $(date +%Y%m%d%H%M%S) ]
# As it turns out, my lovely date parsing function is not needed, because the damn ticket just prints Expired instead of a date.
	if [ $(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5}') == ">>>Expired<<<" ]
	then
		echo "Existing ticket expired; please re-authenticate."
		kinit -c ~/.kcaches/cache_FNAL adasgupt@FNAL.GOV
		kfnal
	fi
}
function sshfnal
{
	kfnal
	if [ $# == 0 ]; then
		ssh -Y adasgupt@cmslpc-sl6.fnal.gov
		return 0
	fi
	if [[ "$1" =~ [^0-9] ]]; then
		echo "Non-digit detected; check input string." >&2
		return 1
	fi
	ssh -Y adasgupt@cmslpc${1}.fnal.gov
}

# cmsusr logon and webpage tunnel aliases
function sshcms
{
	if [ $# == 0 ]; then
		ssh adasgupt@cmsusr.cern.ch
		return 0
	fi
	if [ "$1" == "-t" ]; then
		kcern
		ssh -t adasgupt@lxplus.cern.ch -L 1080:localhost:1081 ssh -ND 1081 cmsusr
		return 0
	fi
	if [[ "$1" =~ [^0-9] ]]; then
		echo "Invalid target; choose from 0-4." >&2
		return 1
	fi
	ssh adasgupt@cmsusr${1}.cern.ch
}
