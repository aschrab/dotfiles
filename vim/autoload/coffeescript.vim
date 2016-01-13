function! coffeescript#fold(line)
	let line = getline(a:line)

	" Lines inside of string use same fold level as previous line {{{2
	if synIDattr(synID(a:line,1,0), 'name') == 'coffeeString'
		return "="
	endif "}}}2

	" Keep same level for empty lines {{{2
	if line =~ '\v^\s*$'
		return '='
	endif "}}}2

	let level = python#lineLevel(a:line, line)
	let blockStart = '\v(^\s*class\s|[-=]\>\s*$)'

	" Start of class or method (including decorators) starts a fold {{{2
	if line =~ blockStart
		let level+=1
		let prv = a:line-1
		let prvline = getline(prv)
		if prvline =~ '^\s*@'
			return level
		else
			return '>' . level
		endif
	endif "}}}2

	" Check if line level is lower than previous level {{{2
	" Would use foldlevel() function, but that's returning -1
	let lnum = a:line
	while lnum >= 2
		let lnum-=1
		let prvline = getline(lnum)
		if  prvline =~ blockStart
			if level <= python#lineLevel(lnum, prvline)
				return level
			endif
			break
		endif
	endwhile "}}}2

	" Anything else is same as previous line
	return '='

endfunction

" vim: foldmethod=marker
