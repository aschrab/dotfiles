if exists("b:current_syntax")
  finish
endif

syn case match

syn region lsmEntry matchgroup=lsmDelim start="^Begin4$" end="^End$" transparent fold contains=lsmField
" syn match lsmStart "^Begin4\s*$"

syn match lsmField "\v^(Title|Version|Entered-date|Description|Keywords|Author|Maintained-by|Primary-site|Alternate-site|Original-site|Platforms|Copying-policy)\ze:" contained

hi def link lsmDelim Comment
hi def link lsmField Keyword

let b:current_syntax = 'lsm'
