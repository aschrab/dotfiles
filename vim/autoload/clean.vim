function! clean#CWD ()
	let cwd = getcwd()
	let home = expand('~')
	let cwd = substitute(cwd, home, '~', '')
	return cwd
endfunction

function! clean#TTY ()
  let tty = $TTY
  let tty = substitute( tty, '/dev/', '', '')
  return tty
endfunction
