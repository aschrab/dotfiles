function! RubyMethodFold(line)
	let line = getline(a:line)

	let col = match( line, '\v\s*\zs' )
	let col = virtcol([a:line, col])
	let level = col / &sw
	let level+=1

	if line =~ '\v^\s*(def|module|class) '
		return '>' . level
	endif

	if line =~ '\v^\s*#'
		return level
	endif

	let col = match( line, '\v\zsend>' )
	if col >= 0
		if synIDattr(synID(a:line,col+1,0), 'name') =~ '\vruby(Module|Class|Define)'
			return '<' . level
		endif
	endif

	return '='
endfunction

setlocal foldexpr=RubyMethodFold(v:lnum)
setlocal foldmethod=expr
