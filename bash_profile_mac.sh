#--BASH PREFERENCES--

# Sets username@Kairos to green, full directory to red, commands to blue
# Sets directories to bblue, links to bcyan, socks to bmagenta, pipes to bbrown, executables to bred
export PS1="\[\033[32m\]\u@Kairos: \[\033[31m\]\w\$ \[\033[34m\]"
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

# Sets default editor and line editing to vim; set mode indicator
export EDITOR=vim
set -o vi
bind 'set show-mode-in-prompt on'

# Custom commands
alias sshcern='ssh -Y adasgupt@lxplus.cern.ch'
export CH="adasgupt@lxplus.cern.ch"