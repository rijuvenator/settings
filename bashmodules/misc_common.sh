# bro do you even ?
# function bro { if [ "$1" == "do" -a "$2" == "you" -a "$3" == "even" -a "${@: -1}" == "?" ]; then shift; shift; shift; n="$#"; ${@:1:$((n-1))}; fi; }
function bro
{
    if [ "$1" == "do" -a "$2" == "you" -a "$3" == "even" -a "${@: -1}" == "?" ]
    then
        shift
        shift
        shift
        n="$#"
        ${@:1:$((n-1))}
    fi
}

