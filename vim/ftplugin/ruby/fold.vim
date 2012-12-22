function! RubyMethodFold(line)
	let line = getline(a:line)
	let comment_re = '\v^\s*#(([{}]{3})\@!.)*$'

	if line =~ '.*{{{'
		return 'a1'
	elseif line =~ '.*}}}'
		return 's1'
	endif

	" This line should be folded
	if line =~ '\v^\s*(def|module|class) '
		let lnum = a:line
		let found = 0

		" Include immediately preceding comment lines in this fold
		while lnum > 0
			let lnum-=1
			let line = getline(lnum)

			if line =~ comment_re
				let found = 1
				continue
			endif

			break
		endwhile

		if found
			return '='
		else
			return 'a1'
		endif
	endif

	if line =~ '\v^\s*#'
		let found = 0
		let lnum = a:line
		let start_re   = '\v^\s*(module|class|def)>'

		" If previous line is a comment, this line is part of the same fold
		if getline(lnum - 1) =~ comment_re
			return '='
		endif

		" First line of a comment
		" Look forward through additional comment lines for beginning of a
		" fold block.  If found, start the fold here.
		while lnum < 10000
			let lnum+=1
			let line = getline(lnum)

			if line =~ comment_re
				continue
			elseif line =~ start_re
				let found = 1
			endif

			break
		endwhile

		if found
			return 's1'
		else
			return '='
		endif
	endif

	" end lines indicate end of a fold
	let col = match( line, '\v\zsend>' )
	if col >= 0
		if synIDattr(synID(a:line,col+1,0), 'name') =~ '\vruby(Module|Class|Define)'
			return 's1'
		endif
	endif

	return '='
endfunction

function! RubyMethodFoldText()
	let lnum = v:foldstart

	" Look for first non-comment line
	while lnum < v:foldend
		let line = getline(lnum)
		if line !~ '\v^\s*#'
			break
		endif
		let lnum+=1
	endwhile

	let lines = v:foldend - v:foldstart + 1
	let line = substitute( line, '\v^\s*', '', '' )

	return printf( '+%s%4d lines: %s', v:folddashes, lines, line )
endf

setlocal foldtext=RubyMethodFoldText()
setlocal foldexpr=RubyMethodFold(v:lnum)
setlocal foldmethod=expr
