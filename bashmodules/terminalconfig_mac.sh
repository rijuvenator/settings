source ~/.bashmodules/terminalconfig_common.sh

# Sets time to orange, username@Kairos to green, full directory to red, commands to blue, everything except commands to bold
export PS1="\[\033[1;38;5;166m\][\t] \[\033[38;5;28m\]\u@Kairos: \[\033[31m\]\w\$ \[\033[0;34m\]"

# Sets directories to bblue, links to bcyan, socks to bmagenta, pipes to bbrown, executables to bred
export CLICOLOR=1
export LSCOLORS=ExGxFxDxBxegedabagacad

# ls with all, colors, file identification, and  human file sizes 
alias ls='ls -GFh'
