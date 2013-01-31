function! statusline#line ()"{{{
	let line=''
	let line2=''

	let line.='%<' " Mark truncation
	let line.='%{statusline#fugitive()}'
	if has('multi_statusline') && &statuslineheight > 1
		let line2.='%{statusline#path()}' " Path to file
	else
		let line.='%{statusline#path()}' " Path to file
	endif
	let line.='%h' " Help buffer flag
	let line.=statusline#modified()
	let line.=statusline#readonly()
	let line.='%w' " Preview window flag
	let line.=' '
	let line.='[%{&ft}%{statusline#format()}%{statusline#encoding()}]'
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
endfunction"}}}

function! statusline#inactive ()"{{{
	let line=''
	let line.='#%{statusline#WindowNumber()} '
	let line.='%{statusline#path()}'
	let line.=statusline#modified()
	return line
endfunction"}}}

function! statusline#path ()"{{{
	let path=bufname('%')

	if path == ""
		return '(no file)'
	endif

	let path=substitute( path, 'fugitive://.*.\zegit//', '', '' )
	let path=substitute( path, $HOME.'/', '~/', '' )

	" Should use strdisplaywidth here, but too new for some systems that I use
	if strlen(path) > winwidth(0) - 20
		let dirs = split( path, '/', 1 )

		let path = ''
		for d in dirs[:-2]
			let m = matchlist( d, '\v(\D{,2})\D*((\d+[.-])+\d+)' )
			if m != []
				let path.= m[1] . m[2] . '/'
			else
				let path.= d[:2] . '/'
			endif
		endfor

		let path.=dirs[-1]
	endif
	return path
endfunction"}}}

function! statusline#format ()"{{{
	let fmt = &ff
	if fmt == 'unix'
		return ''
	endif
	return ',' . fmt
endfunction"}}}

function! statusline#encoding ()"{{{
	let enc = &fenc
	if enc == 'utf-8'
		return ''
	endif
	return ';' . enc
endfunction"}}}

function! statusline#readonly ()"{{{
	if &ro
		return ' %1*⚠%*'
	else
		return ''
	endif
endfunction"}}}

function! statusline#modified ()"{{{
	if &mod
		return ' %2*✻%*'
	else
		return ''
	endif
endfunction"}}}

function! statusline#fugitive ()"{{{
	if exists("*fugitive#statusline")
		let str=fugitive#statusline()
		let str=substitute( str, '^\[Git', '', '' )
		let str=substitute( str, '\]$',   ' ', '' )
		return str
	else
		return ''
	endif
endfunction"}}}

function! statusline#WindowNumber ()"{{{
	let str=tabpagewinnr(tabpagenr())
	return str
endfunction"}}}

" vim: foldmethod=marker
