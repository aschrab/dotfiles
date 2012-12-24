function! statusline#line ()
	let line=''
	let line2=''

	let line.='%<' " Mark truncation
	let line.='#%{statusline#WindowNumber()} '
	let line.='%{statusline#fugitive()}'
	if has('multi_statusline') && &statuslineheight > 1
		let line2.='%f' " Path to file
	else
		let line.='%f' " Path to file
	endif
	let line.='%h' " Help buffer flag
	let line.='%2*%m%*' " Modified flag
	let line.='%1*%r%*' " Readonly flag
	let line.='%w' " Preview window flag
	let line.=' '
	let line.='[%{&ft},%{&ff},%{&fenc}]'
	let line.=' '
	let line.='%=' " Begin right-aligned portion
	let line.=' '
	let line.='ch0x%B' " Code of character under cursor
	let line.=' '

	" cursor position
	let line.='L%l/%L C%c%V'
	"let line.='byt%o %P'

	if line2 != ''
		let line.='%@%<'
		let line.=line2
	endif

	return line
endfunction

function! statusline#fugitive ()
	if exists("*fugitive#statusline")
		return fugitive#statusline()
	else
		return ''
	endif
endfunction

function! statusline#WindowNumber ()
	let str=tabpagewinnr(tabpagenr())
	return str
endfunction
