" Standard stuff
" stop G, gg, etc. from moving to the beginning of the line
set nosol
"autocmd FileType note let g:syntax_cmd="skip"
filetype plugin indent on
syntax on
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set ruler hlsearch

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

" make *.md files be markdown
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

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
"let g:Tex_ViewRule_pdf = '/Applications/Adobe\ Acrobat\ Reader\ DC.app'
let g:Tex_ViewRule_pdf = 'open -a Skim.app'
let g:Tex_GotoError=0

" Compile LaTeX > DVI > PDF
function DVIPDF()
	TTarget dvi
	normal \ll
	execute "!dvipdfmx " . expand("%:r") . ".dvi"
	TTarget pdf
endfunction
