" Vim syntax file
" Language:	   eruby
" Maintainer:  Michael Brailsford <brailsmt@yahoo.com>

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

"Source the html syntax file
ru! syntax/html.vim
unlet b:current_syntax

"Put the ruby syntax file in @rubyTop
syn include @rubyTop syntax/ruby.vim

syn region erubyBlock matchgroup=erubyRubyDelim start=#<%# end=#%># contains=@rubyTop
syn region erubyBlock matchgroup=erubyRubyDelim start=#<%=# end=#%># contains=@rubyTop
syn region erubyComment start=+<%#+ end=#%>#

hi link erubyRubyDelim todo
hi link erubyComment comment
