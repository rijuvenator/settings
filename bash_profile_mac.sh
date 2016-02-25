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

# lxplus remote logon
export CH="adasgupt@lxplus.cern.ch"
function sshcern
{
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
alias kfnal='kinit adasgupt@FNAL.GOV'
function sshfnal
{
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
