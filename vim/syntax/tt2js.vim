runtime! syntax/javascript.vim
unlet b:current_syntax

so <sfile>:p:h/tt2.vim
unlet b:current_syntax
syn cluster javaScriptAll add=@tt2_top_cluster
syn cluster htmlPreProc add=@tt2_top_cluster
