" Create new buffer editing the file named by visual selection or under cursor.
" File name is taken to be relative to the current file.
fu! EditRelative(mods, cnt)
  if a:cnt
    let fname = visual#get()
  else
    let fname = expand("<cfile>")
  endif

  for ext in split(',' . &suffixesadd, ',', 1)
    let fpath = expand("%:h") . "/" . fname .ext
    if filereadable(fpath)
      exec a:mods . " new " . simplify(fpath)
      break
    endif
  endfor
endfu

command! -nargs=0 -count=0 -range EditRelative execute EditRelative(<q-mods>, <count>)
noremap gr :EditRelative<cr>
noremap gR :vert EditRelative<cr>
