if &bg == "light"
	highlight NonText    guifg=grey gui=NONE
	highlight SpecialKey guifg=grey gui=NONE

	highlight StatusLineNC        guifg=DarkBlue    guibg=grey        gui=reverse
	highlight StatusLine          guifg=Blue                          gui=reverse
	" Set colors for portions of the statusline
	highlight User1               guifg=Red                           gui=reverse
	highlight User2               guifg=Yellow                        gui=reverse
endif
