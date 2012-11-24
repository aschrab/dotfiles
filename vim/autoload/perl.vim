function! perl#package_name()
	let pack = expand('%:p')
	let orig = pack

	let pack = substitute( pack, '.*/perl\(/[0-9.]\+\)\?/', '',   '' )
	let pack = substitute( pack, '.*/lib/', '',   '' )
	if pack == orig
		return ''
	endif

	let pack = substitute( pack, '\.pm$',   '',   '' )
	let pack = substitute( pack, '/',       '::', 'g' )

	return pack
endfunction
