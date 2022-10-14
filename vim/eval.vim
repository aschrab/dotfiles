scriptencoding utf-8

let mapleader=','
let maplocalleader=','

" Visually select last pasted or changed text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

let g:jsx_ext_required = 1

if exists('+guifont')
  if has('gui_macvim')
    set guifont=Fira\ Code:h13
    set guifont+=Monoisome\ Regular:h10
    set guifont+=Sauce\ Code\ Powerline:h12
  else
    set guifont=Monoisome\ Semi-Condensed\ 9
    set guifont+=Source\ Code\ Pro\ for\ Powerline\ 9
    set guifont+=Inconsolata\ Medium\ 14
  endif
endif

let g:deoplete#enable_at_startup = 1

" Older versions of vim don't support data structures
if (v:version >= 700)
  " Setup blacklist of plugins that are unavailable or incompatible
  let g:pathogen_blacklist = []

  if !exists('g:sudoed') && ((v:version == 703 && has('patch501')) || v:version > 703)
  else
    let g:pathogen_blacklist += [ 'vorax' ]
  endif

  if (v:version < 704)
    let g:pathogen_blacklist += [ 'diff-enhanced' ]
    let g:pathogen_blacklist += [ 'tsuquyomi' ]
    let g:pathogen_blacklist += [ 'ultisnips' ]
    let g:pathogen_blacklist += [ 'zz_polyglot' ]
  endif

  if !((v:version >= 704) || (v:version == 703 && has('patch1261') && has('patch1264')))
    let g:pathogen_blacklist += [ 'bufexplorer' ]
  endif

  " Only use one of ale|syntastic
  if (v:version >= 800 || has('nvim'))
    let g:pathogen_blacklist += [ 'syntastic' ]
  else
    let g:pathogen_blacklist += [ 'ale' ]
  endif

  if !has('python') && !has('python3')
    let g:pathogen_blacklist += [ 'tern', 'editorconfig' ]
  endif

  if !has('nvim') || !has('python3')
    let g:pathogen_blacklist += [ 'deoplete' ]
  else
    let g:pathogen_blacklist += [ 'tsuquyomi' ]
  endif

  if !has('nvim') || !has('python3')
    let g:pathogen_blacklist += [ 'nvim-lspconfig' ]
  endif

  if !exists('*funcref')
    let g:pathogen_blacklist += [ 'highlighted-yank' ]
  endif

  if has('gui_running') || $FQDN !~? '\M.netapp.com' || $FQDN =~? '\M.rtp.' || $FQDN =~? '\M^aschrab'
    " Start up pathogen if it's available
    " Won't be available on boxes before git submodules have been fetched
    runtime bundle/pathogen/autoload/pathogen.vim
    if exists('*pathogen#infect')
      execute pathogen#infect()
    endif
  endif

  let s:filters = []
  let s:filters += ['converter_truncate_menu']
  let s:filters += ['converter_remove_overlap']
  let s:filters += ['converter_truncate_abbr']
  let s:filters += ['converter_truncate_menu']
  let s:filters += ['converter_remove_paren']
  silent! call deoplete#custom#set('_', 'filters', s:filters)

  if !exists('g:ale_linters')
    let g:ale_linters = {}
  endif
  if !exists('g:ale_linters_ignore')
    let g:ale_linters_ignore = {}
  endif
  let g:ale_linters_ignore['javascript'] = ['tslint', 'tsserver']
  let g:ale_linters_ignore['typescript'] = ['tslint']

  if !exists('g:ale_fixers')
    let g:ale_fixers = {}
  endif
  let g:ale_fixers['javascript'] = ['eslint']
  let g:ale_fixers['typescript'] = ['tslint']

  let g:LanguageClient_serverCommands = {}

  let g:ale_java_javalsp_executable = '/Users/aschrab/vc/java-language-server/dist/launch_mac.sh'
  let g:LanguageClient_serverCommands['java'] = [g:ale_java_javalsp_executable]

  let g:LanguageClient_serverCommands['python'] = ['/usr/local/bin/pyls']

  if !exists('g:polyglot_disabled')
    let g:polyglot_disabled = []
  endif

  let g:polyglot_disabled += ['autoindent'] " Mimics vim-sleuth which I already use
  let g:polyglot_disabled += ['bzl'] " claims any file named `build`
endif

" Screen/tmux can also handle xterm mousiness, but Vim doesn't detect it by default.
if &term ==? 'screen'
  set ttymouse=xterm2
endif

if v:version >= 704 && &term =~? '^screen'
  " Odds are good that this is a modern tmux, so let's pick the best mouse-handling mode.
  set ttymouse=sgr
endif

runtime macros/matchit.vim

filetype plugin indent on

if has('multi_statusline')
  set statuslineheight=1
endif

" Always show tab line in GUI to work around GTK UI
" not resizing correctly when it's added
if has('gui_running') && exists('+showtabline') && !has('gui_macvim')
  set showtabline=2
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

if v:version >= 700
  if has('gui_running')
    auto BufEnter * let &titlestring = "GVim : %{clean#CWD()}"
    auto BufEnter * let &iconstring  = "GVim"
  else
    if exists('$TMUX')
      auto BufEnter * let &titlestring = "Vim@ : %{clean#CWD()}"
    else
      auto BufEnter * let &titlestring = "Vim@%{$host} : %{clean#TTY()} : %{clean#CWD()}"
    endif
    auto BufEnter * let &iconstring  = "Vim@%{$host} : %f (%{clean#TTY()})"
  endif
endif

let perl_extended_vars = 1
let perl_highlight_matches = 1
"let perl_want_scope_in_variables = 1
"let perl_embedded_pod = 1

let g:vimsyn_folding='Paflpr'
let g:xml_syntax_folding = 1
let g:xml_jump_string='→'
let g:xml_tag_completion_map = '💩💣' " The default mapping breaks delimitmate
let g:xmledit_enable_html = 1
let g:perl_fold = 1
let g:perl_fold_anonymous_subs = 1
let g:sh_fold_enabled = 3

let SVNCommandEdit='split'
let SVNCommandDeleteOnHide=1
let SVNCommandEnableBufferSetup=1

" Inform vim how to set window title for additional $TERM types
if &term =~? '\v(xterm|gnome)(-256color)?'
  let &t_ts="\<Esc>]2;"
  let &t_IS="\<Esc>]1;"
  let &t_fs="\<C-G>"
elseif &term =~? '\v(screen)(-256color)?'
  " For some reason using the above settings in tmux causes the :make
  " command to wait for input before giving any indication that the build
  " process has finished.  Use an alternate escape sequence for that.
  let &t_ts="\<Esc>]2;"
  let &t_fs="\<Esc>\\"
endif

if v:version >= 700
  let g:snipMate = {}
  let g:snipMate.scope_aliases = {}
  let g:snipMate.scope_aliases['tt2html'] = 'tt2,html'
endif

let g:powerlineNoPythonError = 1

let g:UltiSnipsNoPythonWarning = 1

let g:UltiSnipsExpandTrigger='<C-X><C-S>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

let g:NumberToggleOff=''
let g:NumberToggleOn=''
let g:NumberToggleTrigger='<leader>n'
let g:numbertoggle_defaultmodeoff = 'number'

" Show changes between buffer and the file on disk
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
if v:version >= 700
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_html_tidy_ignore_errors = [
        \ "attribute name \"*ngif\"",
        \ "proprietary attribute \"autocomplete\"",
        \ "proprietary attribute \"ng-"
        \ ]
endif

let g:ale_c_parse_makefile=1
let g:ale_use_deprecated_neovim = 1

augroup mine
autocmd BufNewFile,BufRead .eslintrc let b:syntastic_checkers = []
augroup END

map <silent> <F1> :NERDTreeToggle<CR>
if v:version >= 700
  let NERDTreeSortOrder=[ 'README.*', '*', '\(\~\|\.\(bak\|swp\)\)$' ]
endif

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

augroup mine
autocmd BufNewFile,BufRead * call AutoPath()
augroup END

if exists('##TermOpen')
  augroup mine
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen,BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  " Map q to re-enter terminal mode rather than start recording a macro.
  autocmd TermOpen * nmap <buffer> q a

  " Map a few keys from normal-mode to apply as if done in terminal mode.
  autocmd TermOpen * nmap <buffer> <C-c> a<C-c>
  autocmd TermOpen * nmap <buffer> <C-d> a<C-d>
  autocmd TermOpen * nmap <buffer> <C-p> a<C-p>
  autocmd TermOpen * nmap <buffer> <C-r> a<C-r>
  autocmd TermOpen * nmap <buffer> <Return> a<Return>
  augroup END
endif

" auto-start NERDTree if vim started with no files and no buffer content
augroup mine
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if exists(':NERDTree') && !argc() && !exists('s:std_in') | NERDTree | endif
" quit vim if NERDTree is only window
"autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

if v:version >= 700
  let g:signify_vcs_list = [ 'git' ]
endif
let g:signify_sign_overwrite = 0

let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_detect_iminsert=0
let g:airline#extensions#branch#enabled = 1
let g:airline_section_x = "%{strlen(&ft)>0?&ft:''}%{statusline#fileinfo()}"
let g:airline_section_y = '%3l/%L»%-3v'
let g:airline_section_z = 'ch0x%04B'
let g:airline_theme='light'
let g:airline#extensions#branch#format = 'airline#ext#branch_format'
let g:airline#extensions#branch#displayed_head_limit = 20

let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType='<c-n>'
let g:SuperTabLongestEnhanced=1
"let g:SuperTabLongestHighlight=1
if v:version >= 700
  let g:SuperTabNoCompleteAfter=['^', ',', '\s', "'", '"']
endif

nmap <Plug>SwapItFallbackIncrement <Plug>SpeedDatingUp
nmap <Plug>SwapItFallbackDecrement <Plug>SpeedDatingDown
vmap <Plug>SwapItFallbackIncrement <Plug>SpeedDatingUp
vmap <Plug>SwapItFallbackDecrement <Plug>SpeedDatingDown

let delimitMate_jump_expansion = 1
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2
let delimitMate_balance_matchpairs = 1
let delimitMate_matchpairs = '(:),[:],{:}'

" Insert current timestamp in UTC, ISO format
imap <C-A>tu 2000-01-01T12:34:56<Left><C-O>d<C-A><Right>Z
" Insert current timestamp in local time
imap <C-A>tl 2000-01-01 12:34:56 -0400<Left><C-O>d<C-X><Right>

let g:Gitv_DoNotMapCtrlKey = 1
let g:Gitv_TruncateCommitSubjects = 1

" Use my own fold expression and settings for markdown
let g:vim_markdown_folding_disabled = 1

let g:vorax_output_window_default_funnel = 2

if exists('g:loaded_unicodePlugin')
  nnoremap ga :<C-U>UnicodeName<CR>
endif

let g:sudoAuth = ' sudo '

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:git_comment_char = 'auto'

if exists(':tnoremap')  " Neovim
  tnoremap <silent> <c-h> <c-\><c-n>:TmuxNavigateLeft<cr>
  tnoremap <silent> <c-j> <c-\><c-n>:TmuxNavigateDown<cr>
  tnoremap <silent> <c-k> <c-\><c-n>:TmuxNavigateUp<cr>
  tnoremap <silent> <c-l> <c-\><c-n>:TmuxNavigateRight<cr>
  tnoremap <silent> <expr> <A-r> '<c-\><c-n>"' . nr2char(getchar()) . 'pi'
  " Cannot use <c-\> here.
  " tnoremap <silent> <c-\> <c-\><c-n>:TmuxNavigatePrevious<cr>
endif

let g:vrc_trigger = '<C-]>'

let g:tern_map_keys = 1

let g:RecoverPlugin_Delete_Unmodified_Swapfile = 1

let g:windowswap_map_keys = 0
nnoremap <silent> <leader>sw :call WindowSwap#EasyWindowSwap()<CR>

silent! call camelcasemotion#CreateMotionMappings(',')

let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
let g:cmdaliasCmdPrefixes = 'verbose debug silent redir tab vert'

vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight
vmap <unique> <S-up>   <Plug>SchleppIndentUp
vmap <unique> <S-down> <Plug>SchleppIndentDown
vmap <unique> Dk <Plug>SchleppDupUp
vmap <unique> Dj <Plug>SchleppDupDown
vmap <unique> Dh <Plug>SchleppDupLeft
vmap <unique> Dl <Plug>SchleppDupRight

let node_host = expand('~/.nodenv/versions/default/bin/neovim-node-host')
if filereadable(node_host)
  let g:node_host_prog = node_host
endif

" Disable perl provider. I don't use it for anything, and healthcheck
" complains when needed module isn't found.
let g:loaded_perl_provider = 0
