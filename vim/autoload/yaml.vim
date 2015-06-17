function! yaml#Fold(line) "{{{1
  let line = getline(a:line)

  " Keep same level for empty lines
  if line =~ '\v^\s*$'
    return '='
  endif

  let lnum = a:line
  let level = yaml#lineLevel(lnum,line)

  " If line ends with a colon, start a new fold for higher level
  if line =~ '\v:\s*$'
    let level = level + 1
    return '>' . level
  else
    " Otherwise just base the level on indent of this line
    return level
  endif
endfunction

function! yaml#lineLevel(lnum,line) "{{{1
	let clmn = match( a:line, '\v\s*\zs' )
	let clmn = virtcol([a:lnum, clmn])
	let level = clmn / &sw
	return level
endfunction

" vim: foldmethod=marker
