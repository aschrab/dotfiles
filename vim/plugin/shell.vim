if exists(":terminal")
  function! Shell (mods, command)
    exec a:mods . " new"
    exec "terminal " . a:command
  endfunction
  silent! command! -nargs=? Shell execute Shell(<q-mods>, <q-args>)
endif
