" https://vi.stackexchange.com/questions/2280/show-only-matching-lines

function! FoldMatches ()
	setlocal foldexpr=getline(v:lnum)=~@/?0:1 foldmethod=expr foldenable
endfunction

silent! command! FoldMatches execute FoldMatches()
