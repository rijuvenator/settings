source ~/.bashmodules/misc_common.sh

# Opens FD3
exec 3>&1

# remove completion for cd so that it will complete environment variables
complete -r cd
