filetype plugin indent on
syntax on
set tabstop=4 shiftwidth=4 softtabstop=4
set laststatus=1

autocmd FileType tex setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType tex map <Leader>cc <S-F7>
autocmd FileType tex map <Leader>ci <F7>
autocmd FileType tex map <Leader>ec <S-F5>
autocmd FileType tex map <Leader>ei <F5>
autocmd FileType tex map <Leader>up <F5>
autocmd FileType tex map <Leader>ld :call DVIPDF()<cr>

set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_ViewRule_pdf = 'open -a Preview'

function DVIPDF()
	TTarget dvi
	normal \ll
	execute "!dvipdfmx " . expand("%:r") . ".dvi"
	TTarget pdf
endfunction
