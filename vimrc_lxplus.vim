filetype plugin indent on
set tabstop=4 shiftwidth=4 softtabstop=4

" Python tab-indented code block visualization
autocmd FileType python let g:pyblock = 0
autocmd FileType python map <leader>vi :call ToggleIndent(g:pyblock)<cr>

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
