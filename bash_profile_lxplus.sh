#--BASH PREFERENCES

# Sets username@hostname to green, full directory to red, commands to blue
# Sets directories to bblue, links to bcyan, executables to bmagenta
export PS1="\[\e[32m\]\u@\h: \[\e[31m\]\w\$ \[\e[34m\]"
LS_COLORS="di=1;34:ln=1;36:ex=1;31"

# Resets color before output!
trap 'echo -ne "\e[0m"' DEBUG

# Sets default editor and line editing to vim
export EDITOR=vim
set -o vi

# ls with all, file identification, human file sizes, and colors
alias ls='ls -Fh --color=auto'
alias crabenv='source /cvmfs/cms.cern.ch/crab3/crab.sh'
alias voms='voms-proxy-init -voms cms'

# git aliases
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gau='git add -u'
alias gcm='git commit -m'
alias gpd='git push origin master'

# Sets $ROOTSYS directory
# export ROOTSYS="/afs/cern.ch/sw/lcg/app/releases/ROOT/5.34.32/x86_64-slc6-gcc49-opt/root/"

# Sets directory variables
export WS="/afs/cern.ch/work/a/adasgupt"
export EOSDIR="/eos/cms/store/user/adasgupt"
export EOSROOT="root://eoscms//eos/cms/store/user/adasgupt"
export EOSSRM="srm://srm-eoscms.cern.ch//eos/cms/store/user/adasgupt"