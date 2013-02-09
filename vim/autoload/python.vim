function! python#MethodFold(line)
	let line = getline(a:line)

	let col = match( line, '\v\s*\zs' )
	let col = virtcol([a:line, col])
	let level = col / &sw
	let level+=1

	" Start of class or method starts a fold
	if line =~ '\v^\s*(def|class)\s'
		return '>' . level

	" Other lines that don't begin with whitespace aren't in a fold
	elseif line =~ '\v^\S'
		" Unless inside of a string
		if synIDattr(synID(a:line,1,0), 'name') != 'pythonString'
			return 0
		end
	endif

	" Anything else is same as previous line
	return '='
endfunction
