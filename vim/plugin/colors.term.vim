if &bg == "light"
	highlight Visual              ctermfg=Yellow      ctermbg=black
	highlight VisualNOS           ctermfg=Yellow      ctermbg=grey        cterm=reverse
	highlight NonText             ctermfg=DarkBlue
	highlight SpecialKey          ctermfg=Yellow
	highlight StatusLineNC        ctermfg=DarkBlue    ctermbg=grey        cterm=reverse
	highlight StatusLine          ctermfg=Blue                            cterm=reverse
	" Set colors for portions of the statusline
	highlight User1               ctermfg=Red                             cterm=reverse
	highlight User2               ctermfg=Yellow                          cterm=reverse

	highlight Comment             ctermfg=DarkRed
	highlight Constant            ctermfg=DarkMagenta
	highlight String              ctermfg=Black       ctermbg=Cyan

	" Set fg color for bad spellings in addition to bg, to ensure it's visible
	highlight SpellBad            ctermfg=White       ctermbg=Red
	" Don't do any coloring for non-capitalized words.  Too often wanted.
	highlight SpellCap            ctermfg=NONE        ctermbg=NONE

	highlight rubyStringDelimiter ctermfg=Blue
	highlight rubyInterpolation   ctermfg=DarkYellow  ctermbg=Cyan
	highlight rubyEscape          ctermfg=DarkBlue    ctermbg=Cyan

	highlight DiffDelete          ctermfg=white       ctermbg=Red         cterm=NONE
	highlight DiffAdd             ctermfg=white       ctermbg=Green       cterm=NONE
	highlight DiffChange          ctermfg=white       ctermbg=Yellow      cterm=NONE
	highlight DiffText            ctermfg=white       ctermbg=Magenta     cterm=NONE
endif
