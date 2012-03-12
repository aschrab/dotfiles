" vim: fdm=marker
:version 4.0
scriptencoding utf-8

let mapleader=','

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
" Disable and reenable filetype support to support added paths
filetype off
filetype plugin indent on

source ~/.vim/functions.vim

set statusline=%<%f%h%m%r%w\ [%{&ft},%{&ff},%{&fenc}]\ %=\ L%l\/%LCol%c%V\ byt%o\ ch0x%B\ %P
auto BufEnter * let &titlestring = "Vim@%{hostname()} : %{CleanTTY()} : %{CleanCWD()}"

let perl_extended_vars = 1
let perl_highlight_matches = 1
"let perl_want_scope_in_variables = 1
"let perl_embedded_pod = 1

let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:perl_fold = 1

let SVNCommandEdit='split'
let SVNCommandDeleteOnHide=1
let SVNCommandEnableBufferSetup=1

" Inform vim how to set window title for additional $TERM types
if &term =~ '\(gnome-256color\|screen\)'
	let &t_ts="\<Esc>]2;"
	let &t_fs="\<C-G>"
endif

set t_Co=16
syntax on
" Custom colors {{{
if &bg == "light"
highlight Comment ctermfg=DarkRed
highlight Constant ctermfg=DarkMagenta
highlight procmailAction ctermfg=DarkGreen
highlight procmailCondition ctermfg=DarkBlue

highlight Visual ctermfg=Yellow ctermbg=black
highlight VisualNOS ctermfg=Yellow ctermbg=grey cterm=reverse
highlight NonText ctermfg=DarkBlue guifg=grey gui=NONE
highlight SpecialKey ctermfg=Yellow guifg=grey gui=NONE
highlight StatusLineNC ctermfg=DarkBlue ctermbg=grey cterm=reverse
highlight StatusLine ctermfg=Blue cterm=reverse
highlight link smVar Identifier

highlight String ctermbg=Cyan ctermfg=Black
highlight rubyStringDelimiter ctermfg=Blue
highlight rubyInterpolation ctermbg=Cyan ctermfg=DarkYellow
highlight rubyEscape ctermbg=Cyan ctermfg=DarkBlue

highlight diffRemoved ctermfg=Red
highlight diffAdded ctermfg=Blue
end
"}}}

" Miscellaneous options {{{
set viminfo=!,s1,%,'20,f1,c,h,r/tmp,r/media,n~/.viminfo
set display+=lastline
set shiftwidth=4
set tabstop=4
set autoindent
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
hi CursorLine   cterm=NONE ctermbg=darkred guibg=darkred guifg=white
hi CursorColumn ctermbg=yellow
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
set tags=tags,TAGS,./tags;,./TAGS;

set foldopen=mark,quickfix,tag,block,hor,search,jump
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

" Abbreviations/automatic spelling correction {{{
"iab fo of " Too short, problematic when editing XSLT files for fop
iab teh the
iab adn and
iab nad and
iab anme name
iab taht that
iab tset test
iab thsi this
iab Thsi This
iab THis This
iab wtih with
iab yoru your
iab fiel file
iab lable label
iab shfit shift
iab lenght length
iab ube unsolicited bulk email
iab UBE Unsolicited Bulk Email
cab ack Ack
"}}}

noremap <C-E> <End>
map <c-J> gqip
map <C-N> <C-W>j<C-W>_
map <C-P> <C-W>k<C-W>_
inoremap  
inoremap <C-]> <C-X><C-]>
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>
inoremap <C-e> <esc>
map gf :new <cfile>
nmap <silent> <Leader>f :CommandT<CR>

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

"dig 00 176
dig !! 161
dig ?? 191
dig SS 167
dig ?! 8253 " Interrobang


" autocmd BufRead *.[ch] set cindent
set cinoptions+=l1,(0,t0
set cinkeys=0{,0}:,!^F,o,O,e
au BufNewFile,BufRead *.c,*.h,*.pl,*.pm set cindent showmatch textwidth=0
au BufNewFile,BufRead /usr/src/linux* set tags=/usr/src/linux/tags
au FileType sm  set noexpandtab
au FileType zone  set noexpandtab
au FileType cpp set noexpandtab ai si cindent
au BufNewFile,BufRead */zone/* set ft=zone

" Go to remembered position in file if it's on a valid line number
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm `\"")|endif|endif
augroup JumpCursorOnEdit
  au!
  autocmd BufReadPost *
    \ if !exists("b:nojump") && expand("<afile>:p:h") !=? $TEMP |
    \   if line("'\"") > 1 && line("'\"") <= line("$") |
    \     let JumpCursorOnEdit_foo = line("'\"") |
    \     let b:doopenfold = 1 |
    \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
    \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
    \        let b:doopenfold = 2 |
    \     endif |
    \     exe JumpCursorOnEdit_foo |
    \   endif |
    \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter *
    \ if exists("b:doopenfold") |
    \   exe "normal zv" |
    \   if(b:doopenfold > 1) |
    \       exe  "+".1 |
    \   endif |
    \   unlet b:doopenfold |
    \ endif
augroup END 

set bs=2
set secure

" Show changes between buffer and the file on disk
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

:if filereadable(expand("~/.vim/local.vim"))
	source ~/.vim/local.vim
:endif

source ~/.vim/projects.vim
