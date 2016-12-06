setlocal cursorline

nnoremap <buffer> <silent> <C-C> :Cycle<CR>

nnoremap <buffer> <silent> <C-P> :Pick<CR>
nnoremap <buffer> <silent> <C-S> :Squash<CR>
nnoremap <buffer> <silent> <C-E> :Edit<CR>
nnoremap <buffer> <silent> <C-R> :Reword<CR>
nnoremap <buffer> <silent> <C-F> :Fixup<CR>

nnoremap <buffer> K ^w:Gsplit <C-r><C-w><CR>
