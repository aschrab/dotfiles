setlocal formatoptions+=rawn2
setlocal spell

autocmd CursorMoved,CursorMovedI <buffer> call autoformat#mail()
