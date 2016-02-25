# If not running interactively, don't do anything
[[ $- == *i* ]] || return

#--BASH PREFERENCES

# Sets time to orange, username@hostname to green, full directory to red, commands to blue, everything except commands to bold
export PS1="\[\e[1;38;5;166m\][\t] \[\e[38;5;28m\]\u@\h: \[\e[31m\]\w\$ \[\e[0;34m\]"
# Colors output of ls. Bold means not text, don't open in a text editor.
# directories are blue, links are cyan, executables are red, graphics files are green,
# C files are purple, header files are orange, python files are teal, root files are light blue,
# archive files are pink
LS_COLORS="di=1;34:ln=1;36:ex=1;91:*.eps=1;32:*.pdf=1;32:*.png=1;32:*.jpg=1;32:*.cc=38;5;90:*.C=38;5;90:*.cpp=38;5;90:*.h=38;5;166:*.hh=38;5;166:*.py=38;5;30:*.pyc=1;38;5;30:*.root=1;38;5;33:*.tar=1;38;5;201:*.tgz=1;38;5;201:*.gz=1;38;5;201:*.zip=1;38;5;201:*.7z=1;38;5;201"

# Resets color before output!
trap 'echo -ne "\e[0m"' DEBUG

# Sets default editor and line editing to vim
export EDITOR=vim
set -o vi

# ls with all, file identification, human file sizes, and colors
alias ls='ls -Fh --color=auto'

# crab and voms proxy aliases
alias crabenv='source /cvmfs/cms.cern.ch/crab3/crab.sh'
alias voms='voms-proxy-init -voms cms'

# remove completion for cd so that it will complete environment variables
complete -r cd

# git aliases
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gau='git add -u'
alias gcm='git commit -m'
alias gpd='git push origin master'
alias gs='git status'
alias gd='git diff --cached'

# Sets $ROOTSYS directory
# export ROOTSYS="/afs/cern.ch/sw/lcg/app/releases/ROOT/5.34.32/x86_64-slc6-gcc49-opt/root/"

# Sets directory variables
export WS="/afs/cern.ch/work/a/adasgupt"
export EOSDIR="eos/cms/store/user/adasgupt"
export EOSROOT="root://eoscms//eos/cms/store/user/adasgupt"
export EOSSRM="srm://srm-eoscms.cern.ch//eos/cms/store/user/adasgupt"

# cmslpc remote logon
export FH="adasgupt@cmslpc-sl6.fnal.gov"
alias kfnal="kinit adasgupt@FNAL.GOV"
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

# Sets grep colors: filename to faint, matching text to bright bold red, matching lines to bold, and line numbers and separators to green
# ggrep puts matching lines on their own indented line, and takes out the colon
export GREP_COLORS="fn=2:ms=1;91:mc=1;91:mt=1;91:cx=1:sl=1:ln=32:bn=32:se=32"
function ggrep
{
	sed -n "s/:/\n    /p" <(2>/dev/null grep --color=always "$@")
}

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

# Sets Terminal tab title to current working directory after every command
PROMPT_COMMAND='sett -t "$(basename $PWD)"'

# Sets Terminal tab title to "vim — FILENAME", then opens vim
function vim
{
    if [ "$1" ]; then
		sett -t "vim — "$(basename "$1")
        /usr/bin/vim "$1"
    else
        /usr/bin/vim
    fi
}

# Sets Terminal tab title to "root", then calls root
alias root='sett -t root; root'

# Replacement motd
printf "\n*********************************************************************************\n"
printf "\e[1mWelcome to \e[31m%s\e[30m, " ${HOSTNAME%%.*}
printf "\e[1mrunning \e[32mSLC %s\e[30m. " `sed -nr "/SLC/s/.*\s//gp" /etc/motd`
printf "\e[1mThere are currently \e[34m%s\e[30m users logged in.\n" `users | sed -n "s/\s/\n/gp" | wc -l`
printf "*********************************************************************************\n"

# Logon history
sed -i "1a $(printf "%-10s --- %s\n" ${HOSTNAME%%.*} "`date +"%b %d %Y, %T %Z"`")" ~/logons
sed -ni "1,101p" ~/logons


