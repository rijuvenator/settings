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


