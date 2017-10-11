source ~/.bashmodules/misc_common.sh

#--FRAMEWORK PYTHON--
function fp {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
    else
        /usr/local/bin/python "$@"
    fi
}

# macOS Sierra -- Apple killed GSSAPI authentication so
# I used a copy of the ssh program from a 10.11 box
# and put it in /usr/local/bin. However, scp is still
# broken so I must specify what ssh program to use with
# the -S flag. After that, everything's great
alias scp='scp -S /usr/local/bin/ssh'
