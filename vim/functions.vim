fun! CamelToUnderscore(word)
	let converted = ''
	let pos = 0
	let str = ''

	while pos < strlen(a:word)
		let str = matchstr( a:word, '\C\([A-Z][a-z]\+\|[A-Z]\+\|[a-z]\+\|[^A-Za-z]\+\)', pos )
		if pos > 0
			let converted = converted . '_'
		endif
		let converted = converted . tolower(str)
		let pos = pos + strlen(str)
	endwhile

	return converted
endf

fun! UnderscoreToTitle(word)
	let conv = a:word

	" Remove prefix
	let conv = substitute( conv, '.*:', '', '' )
	let conv = substitute( conv, '_\(.\)', ' \u\1', 'g' )
	let conv = substitute( conv, '^\(.\)', '\u\1', 'g' )

	return conv . ':'
endf

fun! PerlPackageName()
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
endf

