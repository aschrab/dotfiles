" Not using setf command, since the filetype will already be set to text
" Need to override that
au BufNewFile,BufRead chrome_%%*stackoverflow*.txt	setlocal filetype=mkd
au BufNewFile,BufRead chrome_%%*stackexchange*.txt	setlocal filetype=mkd
au BufNewFile,BufRead chrome_%%*superuser.com*.txt	setlocal filetype=mkd
au BufNewFile,BufRead chrome_%%*github.com*.txt	setlocal filetype=mkd
au BufNewFile,BufRead chrome_%%*wikid.netapp.com*.txt	setlocal filetype=mediawiki
