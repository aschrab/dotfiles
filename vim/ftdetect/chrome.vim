" Not using setf command, since the filetype will already be set to text
" Need to override that
au BufNewFile,BufRead chrome_%%*stackoverflow*.txt	setlocal filetype=mkd
