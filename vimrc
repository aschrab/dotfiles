:version 4.0

let perl_extended_vars = 1
let perl_highlight_matches = 1
"let perl_want_scope_in_variables = 1
"let perl_embedded_pod = 1

set t_Co=8
set t_Sf=[3%p1%dm
set t_Sb=[4%p1%dm
syntax on
highlight Comment ctermfg=DarkRed
highlight Constant ctermfg=DarkMagenta
highlight procmailAction ctermfg=DarkGreen
highlight procmailCondition ctermfg=DarkBlue

highlight NonText ctermfg=Blue cterm=NONE
highlight StatusLine ctermfg=Blue ctermbg=Yellow cterm=reverse,bold
highlight StatusLineNC ctermfg=Blue cterm=reverse

set shiftwidth=2
set autoindent
set nobackup
set smarttab
set expandtab
set notitle
set incsearch
set ruler
set showmatch
set formatoptions=tcrq2
set cpoptions=BceFs$
set cmdheight=2
set laststatus=2

" Tell vim to use visual beep then disable visual beep, to keep it silent
set vb
set t_vb=

set listchars=tab:»­,trail:·
set list
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor-blinkon0,r-cr:hor20-Cursor-blinkon0,sm:block-Cursor-blinkon0

iab teh the
iab adn and
iab nad and
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

" .com files are *not* DCL
au! syntax * *.com

au BufNewFile,BufRead muttrc                 so $VIM/syntax/muttrc.vim
autocmd BufRead mutt-* set tw=72
" autocmd BufRead mutt* /^$
" autocmd BufRead mutt* .+1
autocmd BufRead .article* set tw=72
" autocmd BufRead .article* /^$
" autocmd BufRead .article* .+1

"noremap <C-A> <Home>
noremap <C-E> <End>
inoremap  
inoremap  
inoremap  
inoremap  
inoremap  

map ,ad aAaron Schrab <aaron@schrab.com>
map ,af 1G/^From:WD
map ,al aAaron Schrab <listmaster@execpc.com>
map ,ap aAaron Schrab <ats@execpc.com>
map ,aw aAaron Schrab <aarons@execpc.com>

" signature stuff
map ,sd oi-- :r~/.sigs/schrab:r!~/bin/fortune
map ,sf :r!~/bin/fortune
map ,sl oi-- :r~/.sigs/lsm
map ,sm oi-- :r~/.sigs/mega
map ,sp oi-- :r~/.sigs/personal:r!~/bin/fortune
map ,ss :r~/.sigs/spamreply
map ,sw oi-- :r~/.sigs/work
map ,sx :r~/.sigs/lsm.luser

map ,, /^> *$
map ,l 1G}jyGGp:.,$!wc -ld0iLines: dd1G}P
map ,q :%s/^\(> \)*$//
map ,r :.,/^$/!formail -fbY -IX-Envelope -IX-spamrc: -IX-Suspect-Reason: -IX-procmail: -IReceived: -IReturn-Path: -IResent- -IContent-Length: -IX-Loop: -ILines: -IPrecedence:

map ,e :.w !sed -e 's/^\(..[^:(][^:(]*\)[:(]\([0-9][0-9]*\).*/:new +\2 \1/' > $HOME/temp.vim :so $HOME/temp.vim :!rm -f $HOME/temp.vim

map <F2> <ESC>`>a<CR>_<ESC>`<i_<CR><ESC>:s/\(.\)/\1<C-V><C-H>\1/g<CR>J2xkJxX            
dig 00 176
dig !! 161
dig ?? 191

autocmd BufRead Makefile set nosmarttab noexpandtab noautoindent

" autocmd BufRead *.[ch] set cindent
" ME's C settings
set cinoptions=>2,t0,(0,=2
set cinkeys=0{,0}:,!^F,o,O,e
au BufNewFile,BufRead *.c,*.h,*.pl,*.pm set cindent showmatch shiftwidth=2 textwidth=0
au BufNewFile,BufRead /usr/src/linux* set tags=/usr/src/linux/tags

set bs=2
