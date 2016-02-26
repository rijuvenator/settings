#--BASH PREFERENCES--

# Sets time to orange, username@Kairos to green, full directory to red, commands to blue, everything except commands to bold
export PS1="\[\033[1;38;5;166m\][\t] \[\033[38;5;28m\]\u@Kairos: \[\033[31m\]\w\$ \[\033[0;34m\]"
# Sets directories to bblue, links to bcyan, socks to bmagenta, pipes to bbrown, executables to bred
export CLICOLOR=1
export LSCOLORS=ExGxFxDxBxegedabagacad

# Resets color before output!
trap 'echo -ne "\e[0m"' DEBUG

# ls with all, colors, file identification, and  human file sizes 
alias ls='ls -GFh'

# git aliases
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gau='git add -u'
alias gcm='git commit -m'
alias gpd='git push origin master'
alias gs='git status'
alias gd='git diff --cached'

# Sets default editor and line editing to vim; set mode indicator
export EDITOR=vim
set -o vi
bind 'set show-mode-in-prompt on'

#--SSH FUNCTIONS--
# krb5.conf expects the ticket to be in ~/.kcaches/cache, so the directory MUST exist
mkdir -p ~/.kcaches
# kcern and kfnal switch the "active" kerberos ticket to lxplus and cmslpc, check if it's expired, and re-authenticate if so
# sshcern and sshfnal ssh into lxplus and cmslpc; each will take a number string; if specified, ssh'ing into a specific machine will be attempted

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
	datestr=$(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5"#"$6"#"$7"#"$8}')
	if [ $(date -j -f "%b#%d#%H:%M:%S#%Y" $datestr +%Y%m%d%H%M%S) -le $(date +%Y%m%d%H%M%S) ]
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
	datestr=$(klist -c ~/.kcaches/cache | awk '/krbtgt/{print $5"#"$6"#"$7"#"$8}')
	if [ $(date -j -f "%b#%d#%H:%M:%S#%Y" $datestr +%Y%m%d%H%M%S) -le $(date +%Y%m%d%H%M%S) ]
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

#--TAB TITLE FUNCTIONS--

# Sets Terminal titles; -t for tab, -w for window
function sett
{
    if [ "$1" == "-t" ]; then
        printf "\e]1;$2\a"
    fi
    if [ "$1" == "-w" ]; then
        printf "\e]2;$2\a"
    fi
}

# Sets Terminal tab title to current working directory after every command
PROMPT_COMMAND='sett -t $(basename $PWD)'

# Sets Terminal tab title to vim — FILENAME, then opens vim
function vim
{
	if [ "$1" ]; then
		sett -t "vim — "$(basename "$1")
		/usr/bin/vim "$1"
	else
		/usr/bin/vim
	fi
}
