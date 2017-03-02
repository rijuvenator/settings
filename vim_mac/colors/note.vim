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
" cyan are between {}                ; darkcyan
" bold are between --                ; bold
hi clear Normal
set bg&
hi clear
let color_name = "note"
highlight Bold            cterm=bold
highlight BoldBlue        cterm=bold      ctermfg=blue
highlight Blue                            ctermfg=blue
highlight BoldDarkBlue    cterm=bold      ctermfg=darkblue
highlight DarkBlue                        ctermfg=darkblue
highlight BoldRed         cterm=bold      ctermfg=red
highlight Red                             ctermfg=red
highlight BoldDarkRed     cterm=bold      ctermfg=darkred
highlight DarkRed                         ctermfg=darkred
highlight BoldGreen       cterm=bold      ctermfg=darkgreen
highlight Green                           ctermfg=darkgreen
highlight BoldDarkGreen   cterm=bold      ctermfg=darkgreen
highlight DarkGreen                       ctermfg=darkgreen
highlight BoldMagenta     cterm=bold      ctermfg=magenta
highlight Magenta                         ctermfg=magenta
highlight BoldDarkMagenta cterm=bold      ctermfg=darkmagenta
highlight DarkMagenta                     ctermfg=darkmagenta
highlight BoldCyan        cterm=bold      ctermfg=cyan
highlight Cyan                            ctermfg=cyan
highlight BoldDarkCyan    cterm=bold      ctermfg=darkcyan
highlight DarkCyan                        ctermfg=darkcyan

highlight Orange                          ctermfg=166
highlight Gray                            ctermfg=gray
highlight DarkBlueUnderl  cterm=underline ctermfg=darkblue
