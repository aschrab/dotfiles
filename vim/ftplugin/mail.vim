setlocal formatoptions+=rawn2
setlocal spell

autocmd CursorMoved,CursorMovedI <buffer> call autoformat#mail()

" Set window to title to subject
autocmd BufEnter,BufWrite <buffer> let &titlestring = substitute(getline(search('^Subject:', 'n')), '\v^Subject:\s*(.{,20}).*', '\1', "")

" Move past headers
call search('^$', '')
normal j
