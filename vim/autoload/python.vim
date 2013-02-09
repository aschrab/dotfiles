function! python#MethodFold(line)
	let line = getline(a:line)

	let col = match( line, '\v\s*\zs' )
	let col = virtcol([a:line, col])
	let level = col / &sw
	let level+=1
	let col+=1

	if line =~ '\v^\s*(def|class)\s'
		return '>' . level
	endif

	return '='
endfunction
