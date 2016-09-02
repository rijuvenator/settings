" Standard stuff
filetype plugin indent on
syntax on
set tabstop=4 shiftwidth=4 softtabstop=4
set ruler hlsearch

" Syntax for .note files
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
autocmd FileType note syntax match Green /^# .*/
autocmd FileType note highlight Red ctermfg=red
autocmd FileType note syntax match Red /\[.\{-}\]/
autocmd FileType note highlight Magenta ctermfg=magenta
autocmd FileType note syntax match Magenta /\`.\{-}\`/
autocmd FileType note highlight Cyan ctermfg=darkcyan
autocmd FileType note syntax match Cyan /{.\{-}\}/

" Commands for .tex files
" 'command/environment''change/insert'
" 'usepackage'
" 'll' but with DVI = 'ld'
autocmd FileType tex setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType tex map <Leader>cc <S-F7>
autocmd FileType tex map <Leader>ci <F7>
autocmd FileType tex map <Leader>ec <S-F5>
autocmd FileType tex map <Leader>ei <F5>
autocmd FileType tex map <Leader>up <F5>
autocmd FileType tex map <Leader>ld :call DVIPDF()<cr>

" Recommended for .tex files
" + viewer stuff to get it to open in Preview on a Mac
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_ViewRule_pdf = 'open -a Preview'

" Compile LaTeX > DVI > PDF
function DVIPDF()
	TTarget dvi
	normal \ll
	execute "!dvipdfmx " . expand("%:r") . ".dvi"
	TTarget pdf
endfunction
