function! fold#markdown (lnum)
	let line = getline(a:lnum)

	if line =~ '^#'
		return '>' . matchend(line, '^#\+')
	endif

	return '='
endfunction
