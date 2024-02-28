function! s:SetManWidth ()
  let win = winwidth(0)
  let width = 80
  if (win < width)
    let width = win
  endif

  let $MANWIDTH=width
endfun

au WinEnter,WinResized,VimEnter * call s:SetManWidth()
