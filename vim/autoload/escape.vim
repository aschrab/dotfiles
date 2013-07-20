" Escape filename for use by :new command
fun escape#filename(path)
	return escape(a:path, ' 	\\')
endf
