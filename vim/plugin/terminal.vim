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

  " Allow using C-\ + C-\ to paste unnamed register
  autocmd TermOpen * tnoremap <buffer> <C-\><C-\> <C-\><C-n>pi
  augroup END
endif
