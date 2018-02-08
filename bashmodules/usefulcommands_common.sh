# Calculator
function calc () { echo "" | awk '{print '"$*"'}'; }

# Columns
function cl() { awk "{print \$$1}" $2; }

# Git aliases
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gb='git branch'
alias gm='git merge'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gau='git add -u'
alias gcm='git commit -m'
alias gpd='git push origin master'
alias gpld='git pull origin master'
