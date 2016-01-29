# If not running interactively, don't do anything
[[ $- == *i* ]] || return

#--BASH PREFERENCES

# Sets time to orange, username@hostname to green, full directory to red, commands to blue, everything except commands to bold
export PS1="\[\e[1;38;5;166m\][\t] \[\e[38;5;28m\]\u@\h: \[\e[31m\]\w\$ \[\e[0;34m\]"
# Sets directories to bblue, links to bcyan, executables to bmagenta
LS_COLORS="di=1;34:ln=1;36:ex=1;31"

# Resets color before output!
trap 'echo -ne "\e[0m"' DEBUG

# Sets default editor and line editing to vim
export EDITOR=vim
set -o vi

# ls with all, file identification, human file sizes, and colors
alias ls='ls -Fh --color=auto'

# Makes CMSSW commands available
# Removed alias; it will be done upon login from now on
#alias cmsset='source /cvmfs/cms.cern.ch/cmsset_default.sh'
source /cvmfs/cms.cern.ch/cmsset_default.sh

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

# Sets $ROOTSYS directory
# export ROOTSYS="/afs/cern.ch/sw/lcg/app/releases/ROOT/5.34.32/x86_64-slc6-gcc49-opt/root/"

# Sets directory variables
export WS="/afs/cern.ch/work/a/adasgupt"
export EOSDIR="eos/cms/store/user/adasgupt"
export EOSROOT="root://eoscms//eos/cms/store/user/adasgupt"
export EOSSRM="srm://srm-eoscms.cern.ch//eos/cms/store/user/adasgupt"

export D3="/uscms_data/d3/adasgupt/"
export EOSFNAL="/eos/uscms/store/user/adasgupt/"

# lxplus remote logon
alias sshcern='ssh -Y adasgupt@lxplus.cern.ch'
export CH="adasgupt@lxplus.cern.ch"

# replacement motd
printf "*********************************************************************************\n"
printf "\e[1mWelcome to \e[31m%s\e[30m, " `echo $HOST | sed -nr "s/\..*//p"`
printf "\e[1mrunning \e[32mSLF %s\e[30m. " `sed -nr "/SLF/s/(.*\(SLF\s|\))//gp" /etc/motd`
printf "\e[1mThere are currently \e[34m%s\e[30m users logged in.\n" `users | sed -n "s/\s/\n/gp" | wc -l`
printf "*********************************************************************************\n"

# logon history
sed -i "1a $(printf "%s --- %s\n" `echo $HOST | sed -n "s/\..*//p"` "`date +"%b %d %Y, %T %Z"`")" ~/logons
sed -ni "1,101p" ~/logons

cd /uscms_data/d3/adasgupt/
