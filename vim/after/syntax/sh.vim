unlet b:current_syntax
syntax include @SQL syntax/sql.vim
syntax region sqlSnip matchgroup=Snip start=+<<-\?\s*\(['"]\?\)SQL\1.*\s*$+ end=+^\s*SQL$+ contains=@SQL
