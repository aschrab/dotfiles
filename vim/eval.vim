
let mapleader=','

" Start up pathogen if it's available
" Won't be available on boxes before git submodules have been fetched
:if filereadable(expand("~/.vim/bundle/pathogen/autoload/pathogen.vim"))
	runtime bundle/pathogen/autoload/pathogen.vim
	call pathogen#infect()
	filetype off
	filetype plugin indent on
:endif

source ~/.vim/functions.vim

set statusline=%<%f%h%m%r%w\ [%{&ft},%{&ff},%{&fenc}]\ %=\ L%l\/%L\ Col%c%V\ byt%o\ ch0x%B\ %P
auto BufEnter * let &titlestring = "Vim@%{hostname()} : %{CleanTTY()} : %{CleanCWD()}"
auto BufEnter * let &iconstring  = "Vim@%{hostname()} : %f (%{CleanTTY()})"

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
if &term =~ '\(xterm\|gnome-256color\|screen\)'
	let &t_ts="\<Esc>]2;"
	let &t_IS="\<Esc>]1;"
	let &t_fs="\<C-G>"
endif

let g:snipMate = {}
let g:snipMate.scope_aliases = {} 
let g:snipMate.scope_aliases['tt2html'] = 'tt2,html'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Show changes between buffer and the file on disk
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
