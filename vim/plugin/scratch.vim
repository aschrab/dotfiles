function! ScratchSpace (...)
	if (a:0 > 1)
		vert new
	else
		new
	endif
	setlocal buftype=nofile
	if (a:0)
		let &filetype = a:1
	endif
endfunction

silent! command! -nargs=* -complete=filetype Scratch execute ScratchSpace(<f-args>)
