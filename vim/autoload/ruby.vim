" Regexp to match comment lines which do not contain a fold marker
let s:comment_re = '\v^\s*#(([{}]{3})@!.)*$'

function! ruby#MethodFold(line) "[[[
	let line = getline(a:line)

	" Fold marker line "[[[
	if line =~ '.*{{{'
		return 'a1'
	elseif line =~ '.*}}}'
		return 's1'
	endif "]]]

	" Setup variables "[[[
	let col = match( line, '\v\s*\zs' )
	let col = virtcol([a:line, col])
	let level = col / &sw
	let level+=1
	let col+=1
    "]]]

	" This line should start a fold "[[[
	if line =~ '\v^\s*(def|module|class) '
		let lnum = a:line
		let found = 0

		" Include immediately preceding comment lines in this fold
		while lnum > 0
			let lnum-=1
			let line = getline(lnum)

			if line =~ s:comment_re
				let found = 1
				continue
			endif

			break
		endwhile

		if found
			return '='
		else
			return '>' . level
		endif
	endif "]]]

	" Comment line "[[[
	if line =~ s:comment_re
		let found = 0
		let lnum = a:line
		let start_re   = '\v^\s*(module|class|def)>'

		" If previous line is a comment, this line is part of the same fold
		if getline(lnum - 1) =~ s:comment_re
			return '='
		endif

		" First line of a comment "[[[
		" Look forward through additional comment lines for beginning of a
		" fold block.  If found, start the fold here.
		while lnum < 10000
			let lnum+=1
			let line = getline(lnum)

			if line =~ s:comment_re
				continue
			elseif line =~ start_re
				let found = 1
			endif

			break
		endwhile "]]]

		if found
			return '>' . level
		else
			return '='
		endif
	endif "]]]

	" end lines indicate end of a fold "[[[
	let col = match( line, '\v\zsend>' )
	if col >= 0
		if synIDattr(synID(a:line,col+1,0), 'name') =~ '\vruby(Module|Class|Define)'
			return '<' . level
		endif
	endif "]]]

	return '='
endfunction "]]]

function! ruby#MethodFoldText() "[[[
	let lnum = v:foldstart

	" Look for first non-comment line"[[[
	while lnum < v:foldend
		let line = getline(lnum)
		if line !~ s:comment_re
			break
		endif
		let lnum+=1
	endwhile "]]]

	let lines = v:foldend - v:foldstart + 1
	let line = substitute( line, '\v^\s*', '', '' )
	let line = substitute( line, '\s*{{{\s*', '', '' )

	return printf( '+%s%4d lines: %s ', v:folddashes, lines, line )
endfunction "]]]

function! ruby#SyntaxFoldText ()
	let lnum = v:foldstart

	while lnum <= v:foldend
		let line = getline(lnum)
		if line =~ '[a-zA-Z]'
			break
		endif
		let lnum+=1
	endwhile

	let line = substitute( line, '\v^\s*', '', '' )
	return printf( '+%s%4d lines: %s ', v:folddashes, v:foldend-v:foldstart+1, line )
endfunction

function! ruby#class_name_for_file ()
  try
    let file = fugitive#buffer().path()
  catch
    let file = expand('%:p')
  endtry

  let klass = g:Abolish.mixedcase(fnamemodify(file, ':t:r'))

  return klass
endfunction

" vim: foldmethod=marker foldmarker=[[[,]]]
