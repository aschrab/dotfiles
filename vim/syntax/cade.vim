if exists("b:current_syntax")
  finish
endif

syn match newrecord	"^NEWRECORD \*\*\*\*"
syn match subrecord	"^\(END\|START\)SUBRECORD.*"

hi def link subrecord	Keyword
hi def link newrecord	Comment

let b:current_syntax = "cade"
