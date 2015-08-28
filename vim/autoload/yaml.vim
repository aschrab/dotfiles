function! yaml#Fold(line) "{{{1
  let lnum = a:line
  let line = getline(lnum)

  " Base level of empty lines on content of next non-empty line
  let lastline = line('$')
  if lnum <= lastline && line =~ '\v^\s*$'
    let lnum = lnum + 1
    let line = getline(lnum)
  endif

  " Determine fold level for line based on indent
  let level = strlen(matchstr(line, '\v^\s*')) / &sw

  " If line ends with a colon, start a new fold for higher level
  if line =~ '\v:\s*$'
    let level = level + 1
    return '>' . level
  else
    " Otherwise just base the level on indent of this line
    return level
  endif
endfunction

" vim: foldmethod=marker
