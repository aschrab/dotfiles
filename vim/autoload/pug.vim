function! pug#foldText ()
  let lnum = v:foldstart

  while lnum <= v:foldend
    let line = getline(lnum)

    if line =~ '[a-zA-Z]'
      break
    endif

    let lnum += 1
  endwhile

  let line = substitute( line, '\v^\s*(//-\s*)?', '', '' )
  let line = substitute( line, '{{{.*', '', '' )
  return printf( '+%s%4d lines: %s ', v:folddashes, v:foldend-v:foldstart+1, line )
endfunction
