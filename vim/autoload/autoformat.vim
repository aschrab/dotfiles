function! autoformat#mail ()
	" Assume that format options are meant for the body
	if !exists("b:body_format_options")
		let b:body_format_options=&l:fo
	endif

	" And that header should use the same format options without "aw"
	if !exists("b:header_format_options")
		let b:header_format_options = substitute( &l:fo, '[aw]', '', 'g' )
	endif

	" Only effective if editing headers, as indicated by "From:" on first line
	if getline(1) =~ '^From:'
		" Start off in the not-in-header state, so that initial format options
		" are not saved as header options
		if !exists('b:inheader')
			let b:inheader = 0
		endif

		" Check if currently in header section, by looking backwards for a
		" blank line.
		" Being on the separator is counted as being in the headers
		if search( '^$', 'bnW' )
			" currently in body, toggle if previously in headers
			if b:inheader
				let b:inheader = 0
				" Save current header format options to restore when returning
				let b:header_format_options = &l:fo
				let &l:fo = b:body_format_options
			endif
		else
			" Currently in the headers, toggle if previously in body
			if !b:inheader
				let b:inheader = 1
				" Save current body format options to restore when returning
				let b:body_format_options = &l:fo
				let &l:fo = b:header_format_options
			endif
		endif
	endif
endfunction
