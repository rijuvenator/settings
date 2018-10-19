source ~/.bashmodules/cern_common.sh
source ~/.bashmodules/cern_sl.sh

# Sets workspace
export WS="/afs/cern.ch/work/a/adasgupt"
export WSC="/afs/cern.ch/work/c/cschnaib"

# LSF job checking function
function CHECKLSF
{
    if [ $# == 0 ]
    then
        COMMAND="cat \$i/STDOUT"
    elif [[ "$1" == "-h" || "$1" == "help" || "$1" == "--help" ]]
    then
        echo 'Usage: CHECKLSF [|cat|echo|COMMAND] [|LINECOUNT|grep] [L...|S...] [PATTERN]'
        echo '  arg 1 can be nothing (default cat), cat, echo, or a command e.g. "grep python \$i/LSFJOB"'
        echo '  arg 2 can be nothing (default cat), LINECOUNT (print if not wc -l), or grep (print if grep)'
        echo '  if arg 2 is grep'
        echo '    arg 3 is L<something> or S<something>, becoming LSFJOB and STDOUT, respectively'
        echo '    arg 4 is PATTERN for grep'
        echo '    arg 5 can be nothing (print if matching lines exist)'
        echo '                 -v      (print if not-matching lines exist)'
        echo '                 -n      (print if matching lines do not exist)'
        echo '                 -nv     (print if not-matching lines do not exist)'
        return 0
    elif [ "$1" == 'cat' ]
    then
        COMMAND="cat \$i/STDOUT"
    elif [ "$1" == 'echo' ]
    then
        COMMAND="echo \$i"
    else
        COMMAND="$1"
    fi

    if [ -z "$2" ]
    then
        for i in LSF*
        do
            eval $COMMAND
        done
        return 0
    elif [[ "$2" =~ ^[0-9]+$ ]]
    then
        LINECOUNT="$2"
        for i in LSF*
        do
            if [ $(wc -l < $i/STDOUT) -ne $LINECOUNT ]
            then
                eval $COMMAND
            fi
        done
        return 0
    elif [ "$2" == 'grep' ]
    then
        if [ -z "$3" ]
        then
            echo "Error: grep but no file (try grep LSFJOB python)"
            return 1
        elif [ -z "$4" ]
        then
            echo "Error: grep FILE but no pattern (try grep LSFJOB python)"
            return 2
        elif [[ "$3" =~ [LS].* ]]
        then
            PATTERN="$4"

            if [[ "$3" =~ L.* ]]
            then
                FILE="LSFJOB"
            elif [[ "$3" =~ S.* ]]
            then
                FILE="STDOUT"
            fi

            if [ -z "$5" ]
            then
                for i in LSF*
                do
                    if grep -q "$PATTERN" $i/$FILE*
                    then
                        eval $COMMAND
                    fi
                done
                return 0
            elif [ "$5" == "-v" ]
            then
                for i in LSF*
                do
                    if grep -q -v "$PATTERN" $i/$FILE*
                    then
                        eval $COMMAND
                    fi
                done
                return 0
            elif [ "$5" == "-n" ]
            then
                for i in LSF*
                do
                    if ! grep -q "$PATTERN" $i/$FILE*
                    then
                        eval $COMMAND
                    fi
                done
                return 0
            elif [ "$5" == "-nv" ]
            then
                for i in LSF*
                do
                    if ! grep -q -v "$PATTERN" $i/$FILE*
                    then
                        eval $COMMAND
                    fi
                done
                return 0
            else
                echo "Error: arg 5 should be nothing, -v, -n, or -nv"
                return 3
            fi
        else
            echo "Error: arg 3 should be L... or S... (try grep LSFJOB python)"
            return 4
        fi
    else
        echo "Error: arg 2 should be nothing, a number, or grep"
        return 5
    fi
}

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

##### EOS Commands ####
## Mount EOS
#alias eosmount='/afs/cern.ch/project/eos/installation/0.3.84-aquamarine/bin/eos.select -b fuse mount'
#alias eosumount='/afs/cern.ch/project/eos/installation/0.3.84-aquamarine/bin/eos.select -b fuse umount'
#alias eosforceumount='killall eosfsd 2>/dev/null; killall -9 eosfsd 2>/dev/null; fusermount -u '
#alias eosremount='eosforceumount ~/eos; eosumount ~/eos; eosmount ~/eos'
#timeout 10s /afs/cern.ch/project/eos/installation/0.3.84-aquamarine/bin/eos.select -b fuse mount ~/eos 2> /dev/null
#x="$?"
#if [ $x -eq "124" ]
#then
#	echo "EOS mount timed out; continuing..." >&2
#elif [ "$x" -ne "0" ]
#then
#	echo "Error code $x" >&2
#	echo "EOS not mounted successfully." >&2
#fi

#### LOGON ROUTINE ####
# Replacement motd
printf "\n*********************************************************************************\n"
printf "\e[1mWelcome to \e[31m%s\e[30m, " ${HOSTNAME%%.*}
printf "\e[1mrunning \e[32mSLC %s\e[30m. " `sed -nr "/SLC/s/.*\s//gp" /etc/motd`
printf "\e[1mThere are currently \e[34m%s\e[30m users logged in.\e[m\n" `users | sed -n "s/\s/\n/gp" | wc -l`
printf "*********************************************************************************\n"
