noremap <C-E> <End>
map <c-J> gqip
inoremap <C-]> <C-X><C-]>
inoremap <C-L> <C-X><C-L>
inoremap <C-e> <esc>
inoremap jl <esc>
inoremap <S-Space> <Space>

" Setup unimpaired-style mappings for jumplist,
" since using ^O for tmux prefix makes the default awkward.
nnoremap [j <C-O>
nnoremap ]j <C-I>

nnoremap gf :sfind <cfile><CR>
vnoremap gf :<C-U>sfind <C-R>=escape#filename(visual#get())<CR><CR>

" Open new tab with new window for current buffer
nnoremap <silent> <C-W>t :<C-U>tab split<CR>

nnoremap <silent> <Leader>a :call SyntaxAttr#SyntaxAttr()<CR>
map <Leader>z <Plug>SimpleFold_Foldsearch

" Delete and change to blackhole register
nnoremap <Leader>d "_d
nnoremap <Leader>c "_c

nnoremap <F5> :MundoToggle<CR>
nnoremap <silent> <F12> :set cursorcolumn!<CR>

" Preserve visual selection after indenting
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Visually select text most recently edited or pasted
nnoremap gV `[v`]

" List contents of all registers (that typically contain pasteable text).
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" Allow backspace to remove digits from numeric prefix for commands.
omap <BS> <Del>

" Using a bracket with lower-case p should always paste after cursor
" capitol P can be used to paste before cursor
nnoremap [p ]p

nnoremap <silent> [k :ALEPrevious<CR>
nnoremap <silent> ]k :ALENext<CR>
nnoremap <silent> [K :ALEFirst<CR>
nnoremap <silent> ]K :ALELast<CR>

" In command line, expand %% to the directory containing the current file
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Support for scroll wheel {{{
map <M-Esc>[62~ <MouseDown>
map! <M-Esc>[62~ <MouseDown>
map <M-Esc>[63~ <MouseUp>
map! <M-Esc>[63~ <MouseUp>
map <M-Esc>[64~ <S-MouseDown>
map! <M-Esc>[64~ <S-MouseDown>
map <M-Esc>[65~ <S-MouseUp>
map! <M-Esc>[65~ <S-MouseUp>
"}}}

map ,x :w<C-M>:r!chmod +x <C-R>=expand('%:S')<C-M><C-M>:w!<C-M>
