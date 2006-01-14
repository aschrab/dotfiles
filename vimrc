" $Id$
" vim: fdm=marker
:version 4.0

set statusline=%<%f%h%m%r%w\ [%{&ft},%{&ff},%{&fenc}]\ %=\ L%l\/%LCol%c%V\ byt%o\ ch0x%B\ %P
auto BufEnter * let &titlestring = "Vim@%{hostname()} : %{getcwd()}"

let perl_extended_vars = 1
let perl_highlight_matches = 1
"let perl_want_scope_in_variables = 1
"let perl_embedded_pod = 1

let g:xml_syntax_folding = 1
let g:javaScript_fold = 1

let SVNCommandEdit='split'
let SVNCommandDeleteOnHide=1
let SVNCommandEnableBufferSetup=1

set t_Co=16
"set t_Sf=[3%p1%dm
"set t_Sb=[4%p1%dm
syntax on
" Custom colors {{{
highlight Comment ctermfg=DarkRed
highlight Constant ctermfg=DarkMagenta
highlight procmailAction ctermfg=DarkGreen
highlight procmailCondition ctermfg=DarkBlue

highlight Visual ctermfg=Yellow ctermbg=black
highlight VisualNOS ctermfg=Yellow ctermbg=grey cterm=reverse
"highlight NonText ctermfg=White cterm=bold guifg=grey gui=NONE
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
"}}}

" Miscellaneous options {{{
set shiftwidth=2
set autoindent
set nobackup
set smarttab
set expandtab
set title
set ignorecase
set smartcase
set incsearch
set ruler
set showmatch
set showcmd
set splitbelow
set formatoptions=tcrq2
set cpoptions=BceFs$
"set cmdheight=2
set laststatus=2
set matchpairs=(:),{:},[:],<:>
set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,latin1,iso-2022-jp,euc,sjis
set pastetoggle=<F4>
set modelines=5
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.o,*~

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
:if &encoding == "utf-8"
  set listchars=tab:Â»Â­,trail:Â·
:else
  set listchars=tab:»­,trail:·
:endif
set list
"}}}

set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor-blinkon0,r-cr:hor20-Cursor-blinkon0,sm:block-Cursor-blinkon0

" Abbreviations/automatic spelling correction {{{
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
iab lenght length
iab ube unsolicited bulk email
iab UBE Unsolicited Bulk Email
"}}}

" .com files are *not* DCL
" au! syntax * *.com

" au BufNewFile,BufRead muttrc                 so $VIM/syntax/muttrc.vim
" autocmd BufRead mutt-* set tw=72
" autocmd BufRead mutt* /^$
" autocmd BufRead mutt* .+1
" autocmd BufRead .article* set tw=72
" autocmd BufRead .article* /^$
" autocmd BufRead .article* .+1

"noremap <C-A> <Home>
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

" Allow backspace to remove digits from numeric prefix for commands.
" Unfortunately, it messes up things in insert mode.
" omap <BS> <Del>

" Quote motions for operators: da" will delete a quoted string.
" Built-in to Vim7
:if version < 700
omap i" :normal vT"ot"<CR>
omap a" :normal vF"of"<CR>
omap i' :normal vT'ot'<CR>
omap a' :normal vF'of'<CR>
:endif

" Mappings for email {{{
map ,ad aAaron Schrab <aaron@schrab.com>
map ,af 1G/^From:WD
map ,al aAaron Schrab <listmaster@execpc.com>
map ,ap aAaron Schrab <ats@execpc.com>
map ,aw aAaron Schrab <aarons@execpc.com>
"}}}

" signature stuff {{{
map ,sd oi-- :r~/.sigs/schrab:r!~/bin/fortune
map ,sf :r!~/bin/fortune
map ,sl oi-- :r~/.sigs/lsm
map ,sm oi-- :r~/.sigs/mega
map ,sp oi-- :r~/.sigs/personal:r!~/bin/fortune
map ,ss :r~/.sigs/spamreply
map ,sw oi-- :r~/.sigs/work
map ,sx :r~/.sigs/lsm.luser
"}}}

" Set mappings for spellchecking to not conflict with SVN commands {{{
nmap <silent> <unique> <Leader>Ss <Plug>SpellCheck
nmap <silent> <unique> <Leader>SA <Plug>SpellAutoEnable
nmap <silent> <unique> <Leader>S? <Plug>SpellProposeAlternatives
nmap <silent> <unique> <Leader>Sl <Plug>SpellChangeLanguage
"}}}

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

"map ,x :perl chmod(01600, $curwin->Buffer->Name):wq!
map ,x :w<C-M>:r!chmod +x %<C-M>:w!<C-M>
map ,, /^> *$
map ,l 1G}jyGGp:.,$!wc -ld0iLines: dd1G}P
map ,q :%s/^\(> \)*$//
map ,r :.,/^$/!formail -fbY -IX-Envelope -IX-spamrc: -IX-Suspect-Reason: -IX-procmail: -IReceived: -IReturn-Path: -IResent- -IContent-Length: -IX-Loop: -ILines: -IPrecedence:

map ,e :.w !sed -e 's/^\(..[^:(][^:(]*\)[:(]\([0-9][0-9]*\).*/:new +\2 \1/' > $HOME/temp.vim :so $HOME/temp.vim :!rm -f $HOME/temp.vim

map <F2> <ESC>`>a<CR>_<ESC>`<i_<CR><ESC>:s/\(.\)/\1<C-V><C-H>\1/g<CR>J2xkJxX            
dig 00 176
dig !! 161
dig ?? 191
dig SS 167

au BufRead *
	\ if getline(1) =~ '^RECORDTYPE:' | setf cade | endif

autocmd BufRead Makefile set nosmarttab noexpandtab noautoindent
filetype indent on
filetype plugin on

" autocmd BufRead *.[ch] set cindent
" ME's C settings
set cinoptions=>2,t0,(0,=2
set cinkeys=0{,0}:,!^F,o,O,e
au BufNewFile,BufRead *.c,*.h,*.pl,*.pm set cindent showmatch shiftwidth=2 textwidth=0
"au BufNewFile,BufRead *.cf so $VIM/syntax/sm.vim
"au BufNewFile,BufRead *.cf set noexpandtab ft=sm
au BufNewFile,BufRead /usr/src/linux* set tags=/usr/src/linux/tags
au FileType sm  set noexpandtab
au FileType zone  set noexpandtab
au FileType cpp set noexpandtab ai si cindent
au BufNewFile,BufRead */zone/* set ft=zone

au BufNewFile,BufRead  svn-commit.* setf svn
au FileType svn map <buffer> <Leader>sd :SVNCommitDiff<CR>

set bs=2
set secure

"=== evoke a web browser
function! Browser ()
    let line0 = getline (".")
    let line = matchstr (line0, "http[^ ]*")
    :if line==""
      let line = matchstr (line0, "ftp[^ ]*")
    :endif
    :if line==""
      let line = matchstr (line0, "file[^ ]*")
    :endif
    let line = escape (line, "#?&;|%")
"   echo line
    exec ":silent !firefox ".line
endfunction 
map \w :call Browser ()<CR> 

"  " The File-Browser&Reader. Very handsome.
"  
"  " The DAU mappings (read std.-texts)
"  " map ,dau o~/.sigs/^V^["dddu__filelist
"  map ,dau o~/.sigs/"dddu__filelist
"  
"  " start the file reader. Directory in register d.
"  "map __filelist :split .^V^M!!ls -l ^V^Rd^V^H ^V^M__LN-__mm
"  map __filelist :split .!!ls -l d <CR>__LN-__mm
"  nn __LN- /[0-9] \K..  \=[0-9]<CR>3E2l
"  " crate mapping for enter
"  " noremap __mm :map  __rm0__LN-mai:r ^V^Rd^V^H^V^V^V^[`a"ay$:q!^V^V^V^M@a^V^V^V^M^V^M
"  noremap __mm :map -mai:r d`a"ay$:q!@a
"  " remove mapping
"  noremap __rm :unmap <CR><CR>
