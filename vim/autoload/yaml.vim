function! yaml#Fold(line) "{{{1
  let line = getline(a:line)

  " Keep same level for empty lines
  if line =~ '\v^\s*$'
    return '='
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
