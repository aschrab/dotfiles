function! ScratchSpace (mods, ...)
	exec a:mods . " new"
	setlocal buftype=nofile
	if (a:0)
		let &filetype = a:1
	endif
endfunction

silent! command! -nargs=* -complete=filetype Scratch execute ScratchSpace(<q-mods>, <f-args>)
