" Copied from http://www.perlmonks.org/?node_id=566364

if exists( "toggle_test_plan" )
	finish
endif
let toggle_test_plan = 1

map <buffer> <leader>p :call ToggleTestPlan()<cr>

function ToggleTestPlan()
	call <SID>SavePosition()
	let curr_line = 1
	while curr_line <= line("$")
		if match(getline(curr_line), 'More\s*tests') > -1
			%s/More tests =>/More 'no_plan'; # /
			call <SID>RestorePosition()
		elseif match(getline(curr_line), 'More\s*''no_plan') > -1
			%s/More 'no_plan';\(\s*#\s*\(\d\+\).*\)\?/\="More tests => " . input("Test Count: ", submatch(2) ) . ";"/
			call <SID>RestorePosition()
		endif
		let curr_line = curr_line + 1
	endwhile
endfunction

function <SID>SavePosition()
	let s:curLine = winline()
	let s:curColumn = wincol()
endfunction

function <SID>RestorePosition()
	exe s:curLine
	exe "normal! ".s:curColumn."|"
endfunction

