function! ScratchSpace (...)
	let cmd = "new +set\\ buftype=nofile"
	if (a:0)
		let cmd = cmd . "\\ filetype=" . a:1
	endif
	exe cmd
endfunction

command! -nargs=? -complete=filetype Scratch execute ScratchSpace(<f-args>)
