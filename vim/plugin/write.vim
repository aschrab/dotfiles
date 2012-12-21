function! Write ()
	call mkdir(expand('%:h'), 'p')
	write
endfunction

command! -nargs=0 W call Write()
