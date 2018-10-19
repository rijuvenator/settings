" stop G, gg, etc. from moving to the beginning of the line
set nosol
filetype plugin indent on
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
" C++ indentation should be 2 spaces
autocmd FileType cpp setlocal ts=2 sw=2 sts=2 et

" Python tab-indented code block visualization
autocmd FileType python let g:pyblock = 0
autocmd FileType python map <leader>vi :call ToggleIndent(g:pyblock)<cr>

" make *.md files be markdown
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

function ToggleIndent(pyblock)
	if a:pyblock == 0
		let g:pyblock = 1
		execute "normal z.ml"
		execute ":%s/\t/|   /g"
		execute "normal `l"
	else
		let g:pyblock = 0
		execute "normal z.ml"
		execute ":%s/|   /\t/g"
		execute "normal `l"
	endif
endfunction
