source ~/.bashmodules/usefulcommands_common.sh

# Sets grep color
export GREP_COLOR="1;35"
function ggrep
{
	sed -n 's/:/\033[m\'$'\n    /p' <(2>/dev/null grep --color=always "$@")
}
