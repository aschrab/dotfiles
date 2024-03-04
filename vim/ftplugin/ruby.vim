setlocal indentkeys-=0#

setlocal foldtext=ruby#SyntaxFoldText()
setlocal foldexpr=ruby#MethodFold(v:lnum)
setlocal foldmethod=syntax
setlocal omnifunc=rubycomplete#Complete

runtime ftplugin/ri.vim

" Allow 'd' to be used as a type of surround to add
let b:surround_100 = "do\n\t\r\nend"

compiler rspec
