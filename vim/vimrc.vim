" vim: fdm=marker
:version 4.0
scriptencoding utf-8

:if 1
	source ~/.vim/eval.vim
:endif

set t_Co=16
:if has("syntax")
	syntax on
:endif

" Miscellaneous options {{{
set viminfo=!,s1,%,'20,f1,c,h,r/tmp,r/media,n~/.viminfo
set hidden
set display+=lastline
set shiftwidth=4
set tabstop=4
set autoindent
set autoread
set nobackup
set smarttab
set title
set ignorecase
set smartcase
set incsearch
set ruler
set showmatch
set showcmd
"set cursorcolumn
"set cursorline
set splitbelow
set formatoptions+=r
set formatoptions+=2
set formatlistpat=^\\s*\\d\\+[\\]:.)}]\\s\\+
set cpoptions+=$
set nrformats=hex
"set cmdheight=2
set laststatus=2
set matchpairs=(:),{:},[:],<:>
set fileformats=unix,dos,mac
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,latin1
set pastetoggle=<F4>
set modeline
set modelines=5
set modeline
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.o,*~
set wildignore+=*.pyc
set tags=tags,TAGS,./tags;,./TAGS;

:if has("folding")
set foldopen=mark,quickfix,tag,block,hor,search,insert,undo
:endif

:if has("persistent_undo")
	set undofile
	set undodir=~/.undo,.
:endif
"}}}

" Don't force sync after writing swap files, to avoid spinning up disk {{{
:if $HOST =~ "frell"
  set swapsync=
  set cmdheight=4
:endif
"}}}

:if $DISPLAY != ""
  set mouse=a
  set clipboard=unnamed,autoselect,exclude:cons\|linux
:endif

" Not many filenames have = in them, so make completion easier
set isfname-==

" Tell vim to use visual beep then disable visual beep, to keep it silent {{{
set vb
set t_vb=
"}}}

" Try to figure out if on a UTF terminal even if locale isn't known.
:if $LANG =~ '\cUTF-\?8'
  set termencoding=utf-8
:endif

" Display tabs and trailing spaces {{{
set listchars=tab:▶·,trail:∙,precedes:«,extends:»
" eol:↲
set list
"}}}

set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor-blinkon0,r-cr:hor20-Cursor-blinkon0,sm:block-Cursor-blinkon0

noremap <C-E> <End>
map <c-J> gqip
map <C-N> <C-W>j<C-W>_
map <C-P> <C-W>k<C-W>_
inoremap <C-]> <C-X><C-]>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>
inoremap <C-e> <esc>
" Control-space
inoremap <C-@> <esc>
map gf :new <cfile><CR>

nnoremap / /\v
vnoremap / /\v

nmap <silent> <Leader>f :CommandT<CR>
nnoremap <silent> <Leader>a :call SyntaxAttr#SyntaxAttr()<CR>
map <Leader>z <Plug>SimpleFold_Foldsearch

nnoremap <F5> :GundoToggle<CR>

" Preserve visual selection after indenting
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Visually select text most recently edited or pasted
nnoremap gV `[v`]

" Allow backspace to remove digits from numeric prefix for commands.
omap <BS> <Del>

" Quote motions for operators: da" will delete a quoted string.
" Built-in to Vim7
:if version < 700
omap i" :normal vT"ot"<CR>
omap a" :normal vF"of"<CR>
omap i' :normal vT'ot'<CR>
omap a' :normal vF'of'<CR>
:endif

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

map ,x :w<C-M>:r!chmod +x %<C-M>:w!<C-M>

:if has("digraphs")
"dig 00 176
dig !! 161
dig ?? 191
dig SS 167
dig ?! 8253 " Interrobang
endif

set cinoptions+=l1,(0,t0
set cinkeys=0{,0}:,!^F,o,O,e

set bs=2
set secure

:if filereadable(expand("~/.vim/local.vim"))
	source ~/.vim/local.vim
:endif

:if 1
source ~/.vim/projects.vim
:endif
