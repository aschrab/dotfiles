" repeat the last tabularize command
nnoremap <leader>tr     :Tabularize<cr>

" tabularize with some common patterns
nnoremap <leader>t=     :Tabularize /=<cr>
nnoremap <leader>t:     :Tabularize /:<cr>
nnoremap <leader>t<bar> :Tabularize /<bar><cr>

" for this map file
nnoremap <leader>tm     :Tabularize /^[^"].*\zs \ze[^ ]/l0<cr>
