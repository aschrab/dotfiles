unlet b:current_syntax
syntax include @SQL syntax/sql.vim
syntax region sqlSnip matchgroup=Snip start=+<<\(['"]\?\)SQL\1.*;\s*$+ end=+^\s*SQL$+ contains=@SQL

unlet b:current_syntax
syntax include @HTML syntax/html.vim
syntax region htmlSnip matchgroup=Snip start=+<<\(['"]\?\)HTML\1.*;\s*$+ end=+^\s*HTML$+ contains=@HTML

let b:current_syntax = "perl"
