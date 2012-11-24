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
