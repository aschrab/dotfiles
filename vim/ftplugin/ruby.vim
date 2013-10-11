setlocal shiftwidth=2
setlocal expandtab
setlocal indentkeys-=0#

"setlocal foldtext=ruby#MethodFoldText()
setlocal foldexpr=ruby#MethodFold(v:lnum)
"setlocal foldmethod=expr
setlocal omnifunc=rubycomplete#Complete

source $HOME/.vim/ftplugin/ri.vim
