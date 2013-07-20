" Return the current visual selection
" Copied from http://stackoverflow.com/a/677918/1507392
function visual#get()
	let reg_save = getreg('"')
	let regtype_save = getregtype('"')
	let cb_save = &clipboard
	set clipboard&

	" Put the current visual selection in the " register
	normal! ""gvy
	let selection = getreg('"')

	" Put the saved registers and clipboards back
	call setreg('"', reg_save, regtype_save)
	let &clipboard = cb_save

	return selection
endfunction
