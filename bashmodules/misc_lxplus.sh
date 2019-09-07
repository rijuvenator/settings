source ~/.bashmodules/misc_common.sh

# Opens FD3
exec 3>&1

# remove completion for cd so that it will complete environment variables
complete -r cd

# this is what complete -r cd is removing
# complete -o nospace -F _cd cd

# this completes environment variables
shopt -s direxpand
