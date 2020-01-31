" vim: fdm=marker
:version 4.0
set encoding=utf-8
scriptencoding utf-8

:if $TERM != 'linux'
  set background=dark
  silent! colorscheme vividchalk
:endif

:if 1
  runtime eval.vim
:endif

set t_Co=16
:if has("syntax")
  syntax on
:endif

" Miscellaneous options {{{
:if has('nvim')
  set viminfo=!,s1,%,'20,f1,c,h,r/tmp,r/media
:else
  set viminfo=!,s1,%,'20,f1,c,h,r/tmp,r/media,n~/.viminfo
:endif
set hidden
set display+=lastline
set scrolloff=1
set sidescrolloff=10
set sidescroll=1
set shiftwidth=2
set expandtab
set tabstop=4
set autoindent
set autoread
set nobackup
set smarttab
set title
set ignorecase
set smartcase
set incsearch
silent! set inccommand=split
set ruler
set number
if exists("+relativenumber")
set relativenumber
endif
set showmatch
set showcmd
"set cursorcolumn
"set cursorline
set splitbelow
set splitright
set formatoptions+=r
set formatoptions+=2
if exists("+formatlistpat")
set formatlistpat=^\\s*\\d\\+[\\]:.)}]\\s\\+
endif
set cpoptions+=$
set nrformats=hex
"set cmdheight=2
set laststatus=2
set matchpairs=(:),{:},[:],<:>
set fileformats=unix,dos,mac
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,latin1
silent! set nofixeol
set pastetoggle=<F4>
set modeline
set modelines=5
set modeline
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.o,*~
set wildignore+=*.pyc
if exists("+wildoptions")
set wildoptions=tagfile
endif
if exists("&wildignorecase")
  set wildignorecase
endif
if exists("&infercase")
  set infercase
endif
if exists("+completeopt")
set completeopt=longest,menuone
endif
set tags=tags,TAGS,./tags;,./TAGS;
"set diffopt+=iwhite
set diffopt+=vertical
silent! set diffopt+=algorithm:patience
silent! set diffopt+=indent-heuristic

set history=1000

:if has("folding")
set foldopen=mark,quickfix,tag,block,hor,search,insert,undo
set foldminlines=2
:endif

:if has("persistent_undo")
  set undofile
  set undodir=~/.undo,.
:endif

set viewoptions-=options

" Shorter time before updating swapfile and triggering CursorHold events
set updatetime=200
"}}}

" Don't force sync after writing swap files, to avoid spinning up disk {{{
:if $HOST =~ "frell"
  set swapsync=
  set cmdheight=4
:endif
"}}}

silent! set mouse=a
:if $DISPLAY != ""
  :if has('unnamedplus')
    set clipboard=unnamedplus
  :else
    set clipboard=unnamed
  :endif
  :if !has('nvim')
    set clipboard+=autoselect,exclude:cons\|linux
  :endif
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
" Color for the following controlled by hl-Whitespace
silent! set listchars=tab:→·,trail:∙
" Set nbsp separately, since it's newer, so it not being known doesn't prevent
" other portions from taking effect.
silent! set listchars+=nbsp:_

" Color for the following controlled by hl-NonText
silent! set listchars+=precedes:«,extends:»
" eol:↲
set list
"}}}

:if has('linebreak')
  let &showbreak = nr2char(0x21AA).' '
:endif

set guioptions+=a " Autoselect
set guioptions-=T " No toolbar
set guioptions-=m " No menubar
" Don't show any scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

:if has('nvim') "&& $TERM =~ 'konsole'
  " method of changing cursor on konsole causes font size to be reset to
  " profile default.
  " Not including the check of $TERM for now, since this problem occurs
  " through tmux sessions.
  set guicursor=
:else
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor-blinkon0,r-cr:hor20-Cursor-blinkon0,sm:block-Cursor-blinkon0
:endif

noremap <C-E> <End>
map <c-J> gqip
inoremap <C-]> <C-X><C-]>
inoremap <C-L> <C-X><C-L>
inoremap <C-e> <esc>
inoremap jl <esc>
inoremap <S-Space> <Space>

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

map ,x :w<C-M>:r!chmod +x <C-R>=expand('%:S')<C-M><C-M>:w!<C-M>

:if has("digraphs")
"dig 00 176 " ∞
dig dg 176 " °
dig oo 176 " °
dig !! 161 " ¡
dig ?? 191 " ¿
dig SS 167 " §
dig ?! 8253 " Interrobang ‽
dig .. 8230 " Ellipsis …
dig eu 8364 " Euro sign
dig mt 8709 " Empty set ∅
dig nl 9216 " null ␀
endif

set cinoptions+=l1,(0,t0
set cinkeys=0{,0}:,!^F,o,O,e

set bs=2
set secure

:if filereadable(expand("~/.vim/local.vim"))
  source ~/.vim/local.vim
:endif

:if 1
  runtime projects.vim
:endif
