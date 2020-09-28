" Make * and # searches case sensitive
nmap <expr> * "/\\C\\<" . expand("<cword>") . "\\><CR>zv"
nmap <expr> # "?\\C\\<" . expand("<cword>") . "\\><CR>zv"
