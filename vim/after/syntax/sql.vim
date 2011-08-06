let b:loaded_sql_syntax = "yes"

if exists("b:loaded_perl_syntax")
else
	unlet b:current_syntax

	syntax include @PERL syntax/perl.vim
	syntax region perlCode start=+^\s*# Start perl$+ end=+^\s*# End perl$+ contains=@PERL

	let b:current_syntax = "sql"
endif
