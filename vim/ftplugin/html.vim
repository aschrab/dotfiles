" This is a wrapper script to add extra html support to xml documents.
" Original script can be seen in xml-plugin documentation.

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
" Don't set 'b:did_ftplugin = 1' because that is xml.vim's responsibility.

let b:html_mode = 1

" On to loading xml.vim
runtime ftplugin/xml.vim

" Don't include <:> in matchpairs, interferes with the XML autoclosing
" let b:delimitMate_matchpairs = "(:),[:],{:}"
