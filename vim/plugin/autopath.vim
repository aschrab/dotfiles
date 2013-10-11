function! AutoPath ()
  let dir = expand('%:p:h')
  let base = expand('~')
  let path = ''

  while stridx(dir, base) == 0
    let lib = dir . '/lib'
    if isdirectory( lib )
      let path .= lib . ','
    endif
    let dir = fnamemodify( dir, ':h' )
  endwhile

  let &l:path = path . &path
endfunction
