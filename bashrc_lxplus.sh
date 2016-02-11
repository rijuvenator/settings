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
alias kfnal="kinit adasgupt@FNAL.GOV"
alias sshfnal="ssh -Y adasgupt@cmslpc-sl6.fnal.gov"
export FH="adasgupt@cmslpc-sl6.fnal.gov"

# replacement motd
printf "\n*********************************************************************************\n"
printf "\e[1mWelcome to \e[31m%s\e[30m, " `echo $HOSTNAME | sed -nr "s/\..*//p"`
printf "\e[1mrunning \e[32mSLC %s\e[30m. " `sed -nr "/SLC/s/.*\s//gp" /etc/motd`
printf "\e[1mThere are currently \e[34m%s\e[30m users logged in.\n" `users | sed -n "s/\s/\n/gp" | wc -l`
printf "*********************************************************************************\n"

# logon history
sed -i "1a $(printf "%-10s --- %s\n" `echo $HOSTNAME | sed -n "s/\..*//p"` "`date +"%b %d %Y, %T %Z"`")" ~/logons
sed -ni "1,101p" ~/logons
