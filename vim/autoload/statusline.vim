function! statusline#fugitive ()
	if exists("*fugitive#statusline")
		return fugitive#statusline()
	else
		return ''
	endif
endfunction

function! statusline#WindowNumber ()
	let str=tabpagewinnr(tabpagenr())
	return str
endfunction
