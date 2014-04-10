function! ReadBurtDetail(burt)
	let burt = a:burt
	let burt = substitute( burt, "burt:/", "", "" )
	let dir = substitute( burt, '[0-9]\{,3\}$', '', '' )
	if empty(dir)
		let dir = "0"
	endif

	let path = "/u/burt/details/" . dir . "/bug." . burt

	echo "Reading " . path
	exe ":1,$!cat " . path
	setlocal readonly buftype=nofile ft=burt foldmethod=syntax
endfunction

au BufReadCmd burt:/{[0-9]*,}[0-9] exe ReadBurtDetail(expand("%"))
