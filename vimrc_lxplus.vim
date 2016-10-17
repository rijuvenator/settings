filetype plugin indent on
set tabstop=4 shiftwidth=4 softtabstop=4

" Syntax for .note files
" Folds between {{{ and }}}
" Smart indent and 2 space tabs
" ^Whitespace are tabs or groups of 2 spaces
" H1 are ^==                         ; bold blue
" H2 are ^===                        ; blue
" list bullets are ^Whitespace - or *; darkblue
" warnings are ^Whitespace!          ; bold red
" green are ^#                       ; darkgreen
" red are between []                 ; red
" magenta are between ``             ; magenta
" bold are between --                ; bold
autocmd BufRead,BufNewFile *.note set filetype=note
autocmd FileType note setlocal foldmethod=marker
autocmd FileType note set smartindent
autocmd FileType note setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType note highlight H1 cterm=bold ctermfg=blue
autocmd FileType note syntax match H1 /^== .*/
autocmd FileType note highlight H2 ctermfg=blue
autocmd FileType note syntax match H2 /^=== .*/
autocmd FileType note highlight ListD ctermfg=darkblue
autocmd FileType note syntax match ListD /^\(\t\|  \)\+- /
autocmd FileType note highlight ListS ctermfg=darkblue
autocmd FileType note syntax match ListS /^\(\t\|  \)\+\* /
autocmd FileType note highlight Warn cterm=bold ctermfg=red
autocmd FileType note syntax match Warn /^\(\t\|  \)*! .*/
autocmd FileType note highlight Bold cterm=bold
autocmd FileType note syntax match Bold /_.\{-}_/
autocmd FileType note highlight Green ctermfg=darkgreen
autocmd FileType note syntax match Green /^\(\t\|  \)*# .*/
autocmd FileType note highlight Red ctermfg=red
autocmd FileType note syntax match Red /\[.\{-}\]/
autocmd FileType note highlight Magenta ctermfg=magenta
autocmd FileType note syntax match Magenta /\`.\{-}\`/
autocmd FileType note highlight Cyan ctermfg=darkcyan
autocmd FileType note syntax match Cyan /{.\{-}\}/
