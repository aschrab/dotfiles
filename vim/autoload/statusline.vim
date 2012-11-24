function! statusline#fugitive ()
	if exists("*fugitive#statusline")
		return fugitive#statusline()
	else
		return ''
	endif
endfunction
