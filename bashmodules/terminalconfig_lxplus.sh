source ~/.bashmodules/terminalconfig_common.sh

# Sets time to orange, username@hostname to green, full directory to red, commands to blue, everything except commands to bold
export PS1="\[\e[1;38;5;166m\][\t] \[\e[38;5;28m\]\u@\h: \[\e[31m\]\w\$ \[\e[0;34m\]"

# Colors output of ls. Bold means not text, don't open in a text editor.
# directories are blue, links are cyan, executables are red, graphics files are green,
# C files are purple, header files are orange, python files are teal, root files are light blue,
# archive files are pink
LS_COLORS="di=1;34:ln=1;36:ex=1;91:*.eps=1;32:*.pdf=1;32:*.png=1;32:*.jpg=1;32:*.cc=38;5;90:*.C=38;5;90:*.cpp=38;5;90:*.h=38;5;166:*.hh=38;5;166:*.py=38;5;30:*.pyc=1;38;5;30:*.root=1;38;5;33:*.tar=1;38;5;201:*.tgz=1;38;5;201:*.gz=1;38;5;201:*.zip=1;38;5;201:*.7z=1;38;5;201"

# ls with all, file identification, human file sizes, and colors
alias ls='ls -Fh --color=auto'
