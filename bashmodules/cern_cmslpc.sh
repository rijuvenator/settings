source ~/.bashmodules/cern_common.sh
source ~/.bashmodules/cern_sl.sh

# additional CMSLPC specific directories
export d3="/uscms_data/d3/adasgupt/"
export EOSFNAL="/eos/uscms/store/user/adasgupt/"

#### SSH to LXPLUS ####
# lxplus remote logon
export CH="adasgupt@lxplus.cern.ch"
function sshcern
{
    if [ $# == 0 ]; then
        ssh -Y adasgupt@lxplus.cern.ch
        return 0
    fi
    if [[ "$1" =~ [^0-9] ]]; then
        echo "Non-digit detected; check input string." >&2
        return 1
    fi
    ssh -Y adasgupt@lxplus${1}.cern.ch
}

# a useful function for formatting the last line of a condor_q output
# first argument needs to be the number of jobs submitted
function condor_s
{
	condor_q adasgupt | tail -n 1 | awk -v tot=$1 '{print tot, "jobs;", (tot-$1), "completed;", $1, "left;", $7, "idle;", $9, "running;", $11, "held."; }'
}

#### LOGON ROUTINE ####
# Replacement motd
if [ $(tput cols) -lt 82 ]
then
    printf "\n*****************************************\n"
    printf "\e[1mWelcome to \e[31m%s\e[30m, " ${HOSTNAME%%.*}
    printf "\e[1mrunning \e[32mSLF %s\e[30m.\n" `sed -nr "/SLF/s/(.*\(SLF\s|\))//gp" /etc/motd`
    printf "\e[1mThere are currently \e[34m%s\e[30m users logged in.\e[m\n" `users | sed -n "s/\s/\n/gp" | wc -l`
    printf "*****************************************\n\n"
else
    printf "\n*********************************************************************************\n"
    printf "\e[1mWelcome to \e[31m%s\e[30m, " ${HOSTNAME%%.*}
    printf "\e[1mrunning \e[32mSLF %s\e[30m. " `sed -nr "/SLF/s/(.*\(SLF\s|\))//gp" /etc/motd`
    printf "\e[1mThere are currently \e[34m%s\e[30m users logged in.\e[m\n" `users | sed -n "s/\s/\n/gp" | wc -l`
    printf "*********************************************************************************\n"
fi
