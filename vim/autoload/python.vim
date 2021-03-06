function! python#lineLevel(lnum, line) "{{{1
	let clmn = match( a:line, '\v\s*\zs' )
	let clmn = virtcol([a:lnum, clmn])
	let level = clmn / &sw
	return level
endfunction "}}}1

function! python#MethodFold(line) "{{{1
	let line = getline(a:line)

	" Keep same level for empty lines {{{2
	if line =~ '\v^\s*$'
		return '='
	endif "}}}2

	" Lines inside of string use same fold level as previous line {{{2
	if synIDattr(synID(a:line,1,0), 'name') == 'pythonString'
		return "="
	endif "}}}2

	let level = python#lineLevel(a:line, line)
	let blockStart = '\v^\s*(\@|(def|class)\s)'

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

	" If blocks at top level should be folded {{{2
	" Not necessarily wanted by itself, but if not folded it screws up folding
	" of classes or methods defined in the block
	if line =~ '^\v(if)\s*'
		return '>1'
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
endfunction "}}}1

function! python#MethodFoldText() "{{{1
	let lnum = v:foldstart
	let lines = v:foldend - v:foldstart + 1

	" Skip decorator lines {{{2
	while lnum < v:foldend
		let line = getline(lnum)
		if line !~ '^\s*@'
			break
		endif
		let lnum+=1
	endwhile "}}}2

	let line = substitute( line, '\v^\s*', '', '' )

	return printf( '+%s%4d lines: %s ', v:folddashes, lines, line )
endfunction "}}}1

" vim: foldmethod=marker
