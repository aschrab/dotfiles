source $HOME/.vim/ftplugin/xml.vim

" Don't include <:> in matchpairs, interferes with the XML autoclosing
let b:delimitMate_matchpairs = "(:),[:],{:}"
