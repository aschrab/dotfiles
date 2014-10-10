function! airline#extensions#vorax#init (ext)
	call a:ext.add_statusline_func('airline#extensions#vorax#apply')
	"call a:ext.add_inactive_statusline_func('airline#extensions#vorax#apply')
endfunction

function! airline#extensions#vorax#apply (...)
	let spc = g:airline_symbols.space

	if &ft == 'connvorax'
		call a:1.add_section('airline_a', spc.'Vorax Connections'.spc)
		call a:1.split()
		return 1
	elseif &ft == 'outputvorax' || &ft == 'sql'
		"let props = vorax#sqlplus#Properties()

		call a:1.add_section('airline_a', spc.'VORAX'.spc)
		call a:1.add_section('airline_b', spc.vorax#sqlplus#SessionOwner().spc)

		call a:1.split()

		let funnel = vorax#output#GetFunnel()
		if funnel == 1
			let format = 'VERTICAL'
		elseif funnel == 2
			let format = 'PAGEZIP'
		elseif funnel == 2
			let format = 'TABLEZIP'
		else
			let format = ''
		endif
		if format != ''
			call a:1.add_section('airline_z', spc.format.spc)
		endif

		return 1
	endif
endfunction
