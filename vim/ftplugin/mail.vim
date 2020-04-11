setlocal formatoptions+=rawn2
setlocal spell

autocmd CursorMoved,CursorMovedI <buffer> call autoformat#mail()

" Move past headers
call search('^$', '')
normal j
