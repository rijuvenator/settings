source ~/.bashmodules/usefulcommands_common.sh

# Sets grep colors: filename to faint, matching text to bright bold red, matching lines to bold, and line numbers and separators to green
# ggrep puts matching lines on their own indented line, and takes out the colon
export GREP_COLORS="fn=2:ms=1;91:mc=1;91:mt=1;91:cx=1:sl=1:ln=32:bn=32:se=32"
function ggrep
{
	sed -n "s/:/\n    /p" <(2>/dev/null grep --color=always "$@")
}
