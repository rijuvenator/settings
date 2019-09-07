source .bashmodules/terminalconfig_mac.sh
source .bashmodules/tabtitles_mac.sh
source .bashmodules/usefulcommands_mac.sh
source .bashmodules/misc_mac.sh
source .bashmodules/cern_mac.sh
# added by Anaconda3 2019.07 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/Riju/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/Riju/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/Riju/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/Riju/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
conda deactivate
