" In the 2014 version of VIM's default python.vim,
" setlocal expandtab is on by default to conform to PEP8
" I only use tabs at the beginning of lines, scrupulously
" so putting this line in .vim/after/ftplugin/python.vim
" calls it after the plugins are loaded.
setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
