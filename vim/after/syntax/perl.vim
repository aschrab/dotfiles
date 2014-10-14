let b:loaded_perl_syntax = "yes"

if exists("b:loaded_sql_syntax")
else
	unlet b:current_syntax
	syntax include @SQL syntax/sql.vim
	syntax region sqlSnip matchgroup=Snip start=+<<\(['"]\?\)SQL\1.*;\s*$+ end=+^\s*SQL$+ contains=@SQL
endif

unlet b:current_syntax
syntax include @JSON syntax/json.vim
syntax region jsonSnip matchgroup=Snip start=+<<\(['"]\?\)JSON\1.*;\s*$+ end=+^\s*JSON$+ contains=@JSON

"unlet b:current_syntax
"syntax include @HTML syntax/html.vim
"syntax region htmlSnip matchgroup=Snip start=+<<\(['"]\?\)HTML\1.*;\s*$+ end=+^\s*HTML$+ contains=@HTML
"
let b:current_syntax = "perl"
