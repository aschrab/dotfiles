
let mapleader=','

if exists("+guifont")
	set guifont=Sauce\ Code\ Powerline:h12,Source\ Code\ Pro\ for\ Powerline\ 9
endif

" Start up pathogen if it's available
" Won't be available on boxes before git submodules have been fetched
let g:pathogen_disabled = [ 'command-t' ]
runtime bundle/pathogen/autoload/pathogen.vim
if exists('*pathogen#infect')
	execute pathogen#infect()
endif

runtime macros/matchit.vim

filetype plugin indent on

if has('multi_statusline')
	set statuslineheight=1
endif

" Jump to given window number with <Leader>{digit}
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

"set statusline=%!statusline#inactive()
"let &l:statusline='%!statusline#line()'
"auto BufEnter,WinEnter * let &l:statusline='%!statusline#line()'
"auto WinLeave * let &l:statusline='%!statusline#inactive()'

auto BufEnter * let &titlestring = "Vim@%{hostname()} : %{clean#TTY()} : %{clean#CWD()}"
auto BufEnter * let &iconstring  = "Vim@%{hostname()} : %f (%{clean#TTY()})"

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
if &term =~ '\v(xterm|gnome-256color)'
	let &t_ts="\<Esc>]2;"
	let &t_IS="\<Esc>]1;"
	let &t_fs="\<C-G>"
elseif &term == 'screen'
	" For some reason using the above settings in tmux causes the :make
	" command to wait for input before giving any indication that the build
	" process has finished.  Use an alternate escape sequence for that.
	let &t_ts="\<Esc>]2;"
	let &t_fs="\<Esc>\\"
endif

let g:snipMate = {}
let g:snipMate.scope_aliases = {} 
let g:snipMate.scope_aliases['tt2html'] = 'tt2,html'

let g:powerlineNoPythonError = 1

let g:UltiSnipsNoPythonWarning = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:NumberToggleOff=''
let g:NumberToggleOn=''
let g:NumberToggleTrigger='<leader>n'
let g:numbertoggle_defaultmodeoff = 'number'

" Show changes between buffer and the file on disk
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_html_tidy_ignore_errors = [
  \ "proprietary attribute \"autocomplete\""
  \ ]

map <silent> <F1> :NERDTreeToggle<CR>

let g:ScreenImpl='Tmux'
let g:ScreenShellInitialFocus='shell'
let g:ScreenShellExpandTabs=1
"let g:ScreenShellQuitOnVimExit=0

function! s:ScreenShellListener()
if exists('g:ScreenShellActive') && g:ScreenShellActive
  nmap <C-c><C-c> :ScreenSend<cr>
  vmap <C-c><C-c> :ScreenSend<cr>
  nmap <C-c><C-x> :ScreenQuit<cr>
else
  nmap <C-c><C-c> :ScreenShell<cr>
endif
endfunction

nmap <C-c><C-c> :ScreenShell<cr>
augroup ScreenShellEnter
autocmd User * call <SID>ScreenShellListener()
augroup END
augroup ScreenShellExit
autocmd User * call <SID>ScreenShellListener()
augroup END

autocmd BufNewFile,BufRead * call AutoPath()

" auto-start NERDTree if vim started with no files
autocmd VimEnter * if !argc() | NERDTree | endif
" quit vim if NERDTree is only window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:signify_vcs_list = [ 'git' ]

let g:airline_powerline_fonts=1
let g:airline_detect_whitespace=0
let g:airline_detect_iminsert=0
let g:airline_enable_branch = 1
let g:airline_section_x = "%{strlen(&ft)>0?&ft:''}%{statusline#fileinfo()}"
let g:airline_section_y = '%3l/%L»%-3c'
let g:airline_section_z = "ch0x%02B"
let g:airline_theme='badwolf'

let g:SuperTabDefaultCompletionType='context'
let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1
let g:SuperTabNoCompleteAfter=['^', ',', '\s']
