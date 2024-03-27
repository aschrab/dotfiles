function! s:ToggleSpaceDiff()
  let opts=&diffopt
  if match(opts, '.*iwhite.*')
    let oper="+"
  else
    let oper="-"
  endif

  return ":set diffopt" . oper . "=iwhite\<cr>"
endfunction

nnoremap <silent> <expr> ,ds <SID>ToggleSpaceDiff()
