" Move current line up or down using S-Up or S-Down
" Works in normal, insert or visual mode
nnoremap <S-Down> :m+<CR>==
nnoremap <S-Up>   :m-2<CR>==
inoremap <S-Down> <Esc>:m+<CR>==gi
inoremap <S-Up>   <Esc>:m-2<CR>==gi
vnoremap <S-Down> :m'>+<CR>gv=gv
vnoremap <S-Up>   :m-2<CR>gv=gv
