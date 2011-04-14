if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	" Strip off .svn-base from file name for determining type
	" Taken from http://stackoverflow.com/questions/3324644/svn-diff-with-vim-but-with-the-proper-filetype
	autocmd! BufRead    *.svn-base execute 'doautocmd filetypedetect BufRead ' . expand('%:r')
	autocmd! BufNewFile *.svn-base execute 'doautocmd filetypedetect BufNewFile ' . expand('%:r')

	au! BufNewFile,BufRead *.tt setf tt2html
augroup END
