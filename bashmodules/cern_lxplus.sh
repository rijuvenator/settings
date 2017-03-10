source ~/.bashmodules/cern_common.sh
source ~/.bashmodules/cern_sl.sh

# Sets workspace
export WS="/afs/cern.ch/work/a/adasgupt"
export WSC="/afs/cern.ch/work/c/cschnaib"

#### SSH to CMSLPC ####
# cmslpc remote logon
export FH="adasgupt@cmslpc-sl6.fnal.gov"
alias kfnal="kinit adasgupt@FNAL.GOV"
function sshfnal
{
    if [ $# == 0 ]; then
        ssh -Y adasgupt@cmslpc-sl6.fnal.gov
        return 0
    fi
    if [[ "$1" =~ [^0-9] ]]; then
        echo "Non-digit detected; check input string." >&2
        return 1
    fi
    ssh -Y adasgupt@cmslpc${1}.fnal.gov
}

#### EOS Commands ####
# Mount EOS
# eosmount='/afs/cern.ch/project/eos/installation/0.3.84-aquamarine/bin/eos.select -b fuse mount'
timeout 10s /afs/cern.ch/project/eos/installation/0.3.84-aquamarine/bin/eos.select -b fuse mount ~/eos 2> /dev/null
x="$?"
if [ $x -eq "124" ]
then
	echo "EOS mount timed out; continuing..." >&2
elif [ "$x" -ne "0" ]
then
	echo $x
	echo "EOS not mounted successfully." >&2
fi

#### LOGON ROUTINE ####
# Replacement motd
printf "\n*********************************************************************************\n"
printf "\e[1mWelcome to \e[31m%s\e[30m, " ${HOSTNAME%%.*}
printf "\e[1mrunning \e[32mSLC %s\e[30m. " `sed -nr "/SLC/s/.*\s//gp" /etc/motd`
printf "\e[1mThere are currently \e[34m%s\e[30m users logged in.\e[m\n" `users | sed -n "s/\s/\n/gp" | wc -l`
printf "*********************************************************************************\n"
