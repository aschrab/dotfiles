if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	au! BufNewFile,BufRead *.tt setf tt2html
	au! BufNewFile,BufRead *.ael setf ael
augroup END
