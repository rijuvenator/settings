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
alias gpl='git pull'
alias gs='git status'
alias gb='git branch'
alias gm='git merge'
alias gco='git checkout'
alias gd='git diff --cached'
alias gau='git add -u'
alias gcm='git commit -m'
alias gpd='git push origin master'
alias gpld='git pull origin master'

# Sets default editor and line editing to vim; set mode indicator
export EDITOR=vim
set -o vi
bind 'set show-mode-in-prompt on'

# Calculator
function calc () { echo "" | awk '{print '"$*"'}'; }

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

# Sets grep color
export GREP_COLOR="1;35"
function ggrep
{
	sed -n 's/:/\033[m\'$'\n    /p' <(2>/dev/null grep --color=always "$@")
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

#--FRAMEWORK PYTHON--
function fp {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
    else
        /usr/local/bin/python "$@"
    fi
}
