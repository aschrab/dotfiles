setlocal shiftwidth=2
setlocal expandtab
setlocal indentkeys-=0#

setlocal foldtext=ruby#SyntaxFoldText()
setlocal foldexpr=ruby#MethodFold(v:lnum)
setlocal foldmethod=syntax
setlocal omnifunc=rubycomplete#Complete

source $HOME/.vim/ftplugin/ri.vim
