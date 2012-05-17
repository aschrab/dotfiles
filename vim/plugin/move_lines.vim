" Move current line up or down using M-K or M-j 
" In normal, insert or visual mode

nnoremap <Esc>j :m+<CR>==
nnoremap <Esc>k :m-2<CR>==
inoremap <Esc>j <Esc>:m+<CR>==gi
inoremap <Esc>k <Esc>:m-2<CR>==gi
vnoremap <Esc>j :m'>+<CR>gv=gv
vnoremap <Esc>k :m-2<CR>gv=gv
