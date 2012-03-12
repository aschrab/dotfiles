function! CleanCWD ()
	let cwd = getcwd()
	let home = expand('~')
	let cwd = substitute(cwd, home, '~', '')
	return cwd
endfunction

function! CleanTTY ()
  let tty = $TTY
  let tty = substitute( tty, '/dev/', '', '')
  return tty
endfunction

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
