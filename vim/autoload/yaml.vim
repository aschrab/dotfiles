function! yaml#Fold(line) "{{{1
  let line = getline(a:line)

  " Keep same level for empty lines {{{2
  if line =~ '\v^\s*$'
    return '='
  endif "}}}2

  let lnum = a:line
  let last = line('$')
  let level = yaml#lineLevel(lnum,line)

  " Look for next non-empty line
  while(lnum < last)
    let lnum = lnum + 1
    let next = getline(lnum)

    if next =~ '\v^\s*$'
      continue " Ignore empty lines
    else
      let nextLevel = yaml#lineLevel(lnum, next)
      if nextLevel > level
        " Start a new fold if next line is indented farther
        return '>' . nextLevel
      endif
    endif
  endwhile

  " No non-empty lines following, or following line has same indent
  " So use the level for this line
  return level

endfunction

function! yaml#lineLevel(lnum,line) "{{{1
	let clmn = match( a:line, '\v\s*\zs' )
	let clmn = virtcol([a:lnum, clmn])
	let level = clmn / &sw
	return level
endfunction

" vim: foldmethod=marker
