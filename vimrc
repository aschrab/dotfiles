:version 4.0

set t_Co=8
set t_Sf=[3%p1%dm
set t_Sb=[4%p1%dm
syntax on
highlight Comment ctermfg=DarkRed
highlight Constant ctermfg=DarkMagenta
highlight procmailAction ctermfg=DarkGreen
highlight procmailCondition ctermfg=DarkBlue

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

iab teh the
iab adn and
iab nad and
iab tset test
iab thsi this
iab Thsi This
iab THis This
iab wtih with
iab yoru your
iab lenght length
iab ube unsolicited bulk email
iab UBE Unsolicited Bulk Email

autocmd BufRead mutt* set tw=72
" autocmd BufRead mutt* /^$
" autocmd BufRead mutt* .+1
autocmd BufRead .article* set tw=72
" autocmd BufRead .article* /^$
" autocmd BufRead .article* .+1

noremap <C-A> <Home>
noremap <C-E> <End>
inoremap  

map a aAaron Schrab <aaron@schrab.com>
map d oi-- :r~/.sigs/schrab:r!~/bin/fortune
map f :r!~/bin/fortune
map l oi-- :r~/.sigs/lsm
map m oi-- :r~/.sigs/mega
map p oi-- :r~/.sigs/personal:r!~/bin/fortune
map q :%s/^\(> \)*$//
map ,r :%!formail -fbY -IX-Envelope: -IX-spamrc: -IX-Suspect-Reason: -IX-procmail: -IReceived:
map s :r~/.sigs/spamreply
map w oi-- :r~/.sigs/work
map x :r~/.sigs/lsm.luser


map <F2> <ESC>`>a<CR>_<ESC>`<i_<CR><ESC>:s/\(.\)/\1<C-V><C-H>\1/g<CR>J2xkJxX            
dig 00 176

autocmd BufRead Makefile set nosmarttab noexpandtab noautoindent

" autocmd BufRead *.[ch] set cindent
" ME's C settings
set cinoptions=>2,t0,(0,=2
set cinkeys=0{,0}:,!^F,o,O,e
au BufNewFile,BufRead *.c,*.h set cindent showmatch shiftwidth=2 textwidth=0

set bs=2
