function! fold#lsmText ()
  let lnum = v:foldstart
  let title = 'no title'

  while lnum <= v:foldend
    let line = getline(lnum)

    if line =~ '^Title'
      let title = substitute(line, '^Title\s*:\s*', '', '')
      break
    endif

    let lnum += 1
  endwhile

  return printf( '+%s%4d lines: %s ', v:folddashes, v:foldend-v:foldstart+1, title )
endfunction
