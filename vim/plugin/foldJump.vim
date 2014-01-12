" Open folds when G is used to jump to a given line number
" but not when used without a count to jump to end of file

function! FoldJump ()
	" Need to copy original count
	let c=v:count

	let line=c
	if line == 0
		let line=line('$')
	endif

	execute "normal! " . line . "G"

	if c != 0 && has("folding")
		normal! zv
	endif
endfunction

command! -count=0 FoldJump :call FoldJump()
nnoremap <silent> G :<C-U>FoldJump<cr>
