function! AddIgnore(lnr, errors)

	let fmt = "// ignore %s"
	if exists("b:lint_ignore")
		let fmt = b:lint_ignore
	endif

	let ignore = printf(fmt, join(a:errors, ", "))
	let ln = getline(a:lnr)
	let indent = matchstr(ln, '\s*')

	call append(a:lnr - 1, indent . ignore)
endfunction

function! IgnoreLint()
	let foo = ale#util#FindItemAtCursor(buffer_number())[0]
	let locations = get(foo, 'loclist', [])
	let lnr = line('.')

	let errors = []
	for locn in locations
		if get(locn, 'lnum', -1) == lnr
			call add(errors, get(locn, 'code'))
		endif
	endfor

	if len(errors) > 0
		call AddIgnore(lnr, errors)
	endif
endfunction

silent! command! IgnoreLint call IgnoreLint()
nmap ,il :IgnoreLint<cr>
