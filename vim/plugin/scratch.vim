function! ScratchSpace (mods, ...)
	let ft = &filetype
	exec a:mods . ' new'
	setlocal buftype=nofile
	if (a:0)
		let &filetype = a:1
	else
		let &filetype = ft
	endif
endfunction

silent! command! -nargs=* -complete=filetype Scratch execute ScratchSpace(<q-mods>, <f-args>)
