let s:current_syntax = b:current_syntax

unlet b:current_syntax
syntax include @SQL syntax/sql.vim
syntax region sqlSnip matchgroup=Snip start=+<<-\?\s*\(['"]\?\)SQL\1\s*$+ end=+^\s*SQL$+ contains=@SQL

unlet b:current_syntax
syntax include @JSON syntax/json.vim
syntax region jsonSnip matchgroup=Snip start=+<<-\?\s*\(['"]\?\)JSON\1\s*$+ end=+^\s*JSON$+ contains=@JSON

let b:current_syntax = s:current_syntax
