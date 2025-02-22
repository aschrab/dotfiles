" vim: fdm=marker
:version 4.0
set encoding=utf-8
scriptencoding utf-8

:if $TERM !=? 'linux'
  set background=dark
  silent! colorscheme vividchalk
:endif

:if 1
  runtime eval.vim
:endif

set t_Co=16
:if has('syntax')
  syntax on
:endif

" Miscellaneous options {{{
set viminfo=!,s1,%,'20,f1,c,h,<0,r/tmp,r/media
:if !has('nvim')
  set viminfofile=~/.viminfo
:endif
set hidden
set display+=lastline
set scrolloff=1
set sidescrolloff=10
set sidescroll=1
set shiftwidth=0
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
" Don't show results of substitute while editing command.
" It's WAY too slow when there are many matches.
silent! set inccommand=
set ruler
set number
if exists('+relativenumber')
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
if exists('+formatlistpat')
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
if exists('+wildoptions')
set wildoptions=tagfile
endif
if exists('&wildignorecase')
  set wildignorecase
endif
if exists('&infercase')
  set infercase
endif
if exists('+completeopt')
set completeopt=longest,menuone
endif
if exists('+spelloptions')
  set spelloptions=camel
endif
set tags=tags,TAGS,./tags;,./TAGS;

silent! set diffopt+=vertical
silent! set diffopt+=algorithm:patience
silent! set diffopt+=indent-heuristic
silent! set diffopt+=linematch:60

set history=1000

:if has('folding')
set foldopen=mark,quickfix,tag,block,hor,search,insert,undo
set foldminlines=2
:endif

:if has('persistent_undo')
  set undofile
  if !has('nvim')
    set undodir=~/.undo,.
  endif
:endif

:if has('nvim')
  set directory=~/.cache/nvim//
:else
  set directory=~/.cache/vim//
:endif

set viewoptions-=options

" Shorter time before updating swapfile and triggering CursorHold events
set updatetime=200
"}}}

" Don't force sync after writing swap files, to avoid spinning up disk {{{
:if $HOST =~? 'frell'
  set swapsync=
  set cmdheight=4
:endif
"}}}

silent! set mouse=a
:if has('mac') || $DISPLAY !=# ''
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
set visualbell
set t_vb=
"}}}

" Try to figure out if on a UTF terminal even if locale isn't known.
:if $LANG =~? '\cUTF-\?8'
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

:if has('nvim') && $TERM =~? 'konsole'
  " method of changing cursor on konsole causes font size to be reset to
  " profile default.
  " Not including the check of $TERM for now, since this problem occurs
  " through tmux sessions.
  set guicursor=
:else
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor-blinkon0,r-cr:hor20-Cursor-blinkon0,sm:block-Cursor-blinkon0
:endif

if has('termguicolors')
  set termguicolors
endif

" Quote motions for operators: da" will delete a quoted string.
" Built-in to Vim7
:if v:version < 700
omap i" :normal vT"ot"<CR>
omap a" :normal vF"of"<CR>
omap i' :normal vT'ot'<CR>
omap a' :normal vF'of'<CR>
:endif

set cinoptions+=l1,(0,t0
set cinkeys=0{,0}:,!^F,o,O,e

set backspace=2
set secure

:if filereadable(expand('~/.vim/local.vim'))
  source ~/.vim/local.vim
:endif

:if 1
  runtime projects.vim
:endif
