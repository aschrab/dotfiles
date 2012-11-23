" Move current line up or down using S-Up or S-Down
" Works in normal, insert or visual mode

" Move single lines in normal mode
nmap <S-Up>   [e
nmap <S-Down> ]e

" Move single line in insert mode
inoremap <S-Down> <Esc>:m+<CR>==gi
inoremap <S-Up>   <Esc>:m-2<CR>==gi

" Move multiple lines in visual mode
vmap <S-Up>   [egv
vmap <S-Down> ]egv
