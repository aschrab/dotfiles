setlocal shiftwidth=2
setlocal expandtab
setlocal indentkeys-=0#

setlocal foldtext=ruby#MethodFoldText()
setlocal foldexpr=ruby#MethodFold(v:lnum)
setlocal foldmethod=expr

source $HOME/.vim/ftplugin/ri.vim

if exists('g:loaded_surround') && !exists('b:surround_'.char2nr(':'))
  let b:surround_{char2nr(':')} = ":\r"
endif
