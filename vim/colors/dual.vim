" Vim color file - dual
" Generated by http://bytefluent.com/vivify 2013-09-12
set background=light
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "dual"

hi IncSearch guifg=#000000 guibg=#00ff00 guisp=#00ff00 gui=NONE ctermfg=NONE ctermbg=10 cterm=NONE
hi WildMenu guifg=#003399 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=18 ctermbg=15 cterm=bold
hi SignColumn guifg=#0033ff guibg=#f2f2f2 guisp=#f2f2f2 gui=NONE ctermfg=27 ctermbg=255 cterm=NONE
hi SpecialComment guifg=#008800 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=28 ctermbg=15 cterm=NONE
hi Typedef guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi Title guifg=#0000ff guibg=#ffffff guisp=#ffffff gui=bold ctermfg=21 ctermbg=15 cterm=bold
hi Folded guifg=#666666 guibg=#f2f2f2 guisp=#f2f2f2 gui=NONE ctermfg=241 ctermbg=255 cterm=NONE
hi PreCondit guifg=#999900 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=100 ctermbg=15 cterm=NONE
hi Include guifg=#666600 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=58 ctermbg=15 cterm=NONE
hi TabLineSel guifg=#ffffff guibg=#003399 guisp=#003399 gui=bold ctermfg=15 ctermbg=18 cterm=bold
hi StatusLineNC guifg=#003399 guibg=#bfbfbf guisp=#bfbfbf gui=italic ctermfg=18 ctermbg=7 cterm=NONE
"hi CTagsMember -- no settings --
hi NonText guifg=#a9a9a9 guibg=#f2f2f2 guisp=#f2f2f2 gui=NONE ctermfg=248 ctermbg=255 cterm=NONE
"hi CTagsGlobalConstant -- no settings --
hi DiffText guifg=#ffffff guibg=#ccffff guisp=#ccffff gui=NONE ctermfg=15 ctermbg=195 cterm=NONE
hi ErrorMsg guifg=#ffffff guibg=#cd0000 guisp=#cd0000 gui=NONE ctermfg=15 ctermbg=160 cterm=NONE
hi Ignore guifg=#ffffff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=15 ctermbg=15 cterm=NONE
hi Debug guifg=#a9a9a9 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=248 ctermbg=15 cterm=NONE
hi PMenuSbar guifg=#000000 guibg=#99cc66 guisp=#99cc66 gui=NONE ctermfg=NONE ctermbg=149 cterm=NONE
hi Identifier guifg=#990099 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=90 ctermbg=15 cterm=NONE
hi SpecialChar guifg=#0000ff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=21 ctermbg=15 cterm=NONE
hi Conditional guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi StorageClass guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi Todo guifg=#ffffff guibg=#006400 guisp=#006400 gui=NONE ctermfg=15 ctermbg=22 cterm=NONE
hi Special guifg=#3366cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=68 ctermbg=15 cterm=NONE
hi LineNr guifg=#999999 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=246 ctermbg=15 cterm=NONE
hi StatusLine guifg=#ffffff guibg=#003399 guisp=#003399 gui=NONE ctermfg=15 ctermbg=18 cterm=NONE
hi Normal guifg=#000000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
hi Label guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#ffffff guibg=#336600 guisp=#336600 gui=bold ctermfg=15 ctermbg=22 cterm=bold
hi Search guifg=#000000 guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=NONE ctermbg=11 cterm=NONE
"hi CTagsGlobalVariable -- no settings --
hi Delimiter guifg=#3366cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=68 ctermbg=15 cterm=NONE
hi Statement guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi SpellRare guifg=#ff00ff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=201 ctermbg=15 cterm=NONE
"hi EnumerationValue -- no settings --
hi Comment guifg=#008800 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=28 ctermbg=15 cterm=NONE
hi Character guifg=#cc0000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=160 ctermbg=15 cterm=NONE
hi Float guifg=#ff6600 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=202 ctermbg=15 cterm=NONE
hi Number guifg=#ff6600 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=202 ctermbg=15 cterm=NONE
hi Boolean guifg=#ff6600 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=202 ctermbg=15 cterm=NONE
hi Operator guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi CursorLine guifg=NONE guibg=#ffffff guisp=#ffffff gui=underline ctermfg=NONE ctermbg=15 cterm=underline
"hi Union -- no settings --
hi TabLineFill guifg=#003399 guibg=#bfbfbf guisp=#bfbfbf gui=NONE ctermfg=18 ctermbg=7 cterm=NONE
hi Question guifg=#4d4d4d guibg=#ffffff guisp=#ffffff gui=italic ctermfg=239 ctermbg=15 cterm=NONE
hi WarningMsg guifg=#cd0000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=160 ctermbg=15 cterm=NONE
hi VisualNOS guifg=#ffffff guibg=#00008b guisp=#00008b gui=NONE ctermfg=15 ctermbg=18 cterm=NONE
hi DiffDelete guifg=#ffffff guibg=#ffcccc guisp=#ffcccc gui=NONE ctermfg=15 ctermbg=224 cterm=NONE
hi ModeMsg guifg=#000000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
hi CursorColumn guifg=NONE guibg=#ffffff guisp=#ffffff gui=underline ctermfg=NONE ctermbg=15 cterm=underline
hi Define guifg=#666600 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=58 ctermbg=15 cterm=NONE
hi Function guifg=#990099 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=90 ctermbg=15 cterm=NONE
hi FoldColumn guifg=#666666 guibg=#f2f2f2 guisp=#f2f2f2 gui=NONE ctermfg=241 ctermbg=255 cterm=NONE
hi PreProc guifg=#666600 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=58 ctermbg=15 cterm=NONE
"hi EnumerationName -- no settings --
hi Visual guifg=#ffffff guibg=#00008b guisp=#00008b gui=NONE ctermfg=15 ctermbg=18 cterm=NONE
hi MoreMsg guifg=#006400 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=22 ctermbg=15 cterm=NONE
hi SpellCap guifg=#0000ff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=21 ctermbg=15 cterm=NONE
hi VertSplit guifg=#003399 guibg=#bfbfbf guisp=#bfbfbf gui=bold ctermfg=18 ctermbg=7 cterm=bold
hi Exception guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi Keyword guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi Type guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi DiffChange guifg=#000000 guibg=#ccccff guisp=#ccccff gui=NONE ctermfg=NONE ctermbg=189 cterm=NONE
hi Cursor guifg=#ffffff guibg=#00008b guisp=#00008b gui=NONE ctermfg=15 ctermbg=18 cterm=NONE
hi SpellLocal guifg=#008b8b guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=30 ctermbg=15 cterm=NONE
hi Error guifg=#ff0000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=196 ctermbg=15 cterm=NONE
hi PMenu guifg=#000000 guibg=#ccff99 guisp=#ccff99 gui=NONE ctermfg=NONE ctermbg=193 cterm=NONE
hi SpecialKey guifg=#993333 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=131 ctermbg=15 cterm=NONE
hi Constant guifg=#ff6600 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=202 ctermbg=15 cterm=NONE
"hi DefinedName -- no settings --
hi Tag guifg=#3366cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=68 ctermbg=15 cterm=NONE
hi String guifg=#cc0000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=160 ctermbg=15 cterm=NONE
hi PMenuThumb guifg=#ffffff guibg=#669933 guisp=#669933 gui=NONE ctermfg=15 ctermbg=107 cterm=NONE
hi MatchParen guifg=#ffffff guibg=#00008b guisp=#00008b gui=NONE ctermfg=15 ctermbg=18 cterm=NONE
"hi LocalVariable -- no settings --
hi Repeat guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi SpellBad guifg=#ff0000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=196 ctermbg=15 cterm=NONE
"hi CTagsClass -- no settings --
hi Directory guifg=#0000ee guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=21 ctermbg=15 cterm=NONE
hi Structure guifg=#0000cc guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=20 ctermbg=15 cterm=NONE
hi Macro guifg=#666600 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=58 ctermbg=15 cterm=NONE
hi Underlined guifg=#0000ee guibg=#ffffff guisp=#ffffff gui=underline ctermfg=21 ctermbg=15 cterm=underline
hi DiffAdd guifg=#ffffff guibg=#ccffcc guisp=#ccffcc gui=NONE ctermfg=15 ctermbg=194 cterm=NONE
hi TabLine guifg=#003399 guibg=#bfbfbf guisp=#bfbfbf gui=NONE ctermfg=18 ctermbg=7 cterm=NONE
hi cursorim guifg=NONE guibg=#660066 guisp=#660066 gui=NONE ctermfg=NONE ctermbg=53 cterm=NONE
"hi clear -- no settings --
hi mbenormal guifg=#cfbfad guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=187 ctermbg=237 cterm=NONE
hi perlspecialstring guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi doxygenspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi mbechanged guifg=#eeeeee guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=255 ctermbg=237 cterm=NONE
hi mbevisiblechanged guifg=#eeeeee guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=255 ctermbg=60 cterm=NONE
hi doxygenparam guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygensmallspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygenprev guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi perlspecialmatch guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi cformat guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi lcursor guifg=NONE guibg=#00ffff guisp=#00ffff gui=NONE ctermfg=NONE ctermbg=14 cterm=NONE
hi doxygenspecialmultilinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi taglisttagname guifg=#808bed guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
hi doxygenbrief guifg=#fdab60 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi mbevisiblenormal guifg=#cfcfcd guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=252 ctermbg=60 cterm=NONE
hi user2 guifg=#7070a0 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=103 ctermbg=60 cterm=NONE
hi user1 guifg=#00ff8b guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=48 ctermbg=60 cterm=NONE
hi doxygenspecialonelinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi doxygencomment guifg=#ad7b20 guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi cspecialcharacter guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
"hi htmlitalic -- no settings --
"hi htmlboldunderlineitalic -- no settings --
"hi htmlbolditalic -- no settings --
hi kde guifg=#ff00ff guibg=NONE guisp=NONE gui=NONE ctermfg=201 ctermbg=NONE cterm=NONE
hi browsefile guifg=#000080 guibg=#E3EFFF guisp=#E3EFFF gui=NONE ctermfg=18 ctermbg=189 cterm=NONE
hi browsecurdirectory guifg=#8b0000 guibg=#FFE9E3 guisp=#FFE9E3 gui=NONE ctermfg=88 ctermbg=224 cterm=NONE
"hi htmlunderlineitalic -- no settings --
"hi htmlbold -- no settings --
"hi htmlboldunderline -- no settings --
"hi htmlunderline -- no settings --
hi spelllocale guifg=NONE guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=NONE ctermbg=11 cterm=NONE
hi htmllink guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi browsesuffixes guifg=#7f7f7f guibg=#f5f5f5 guisp=#f5f5f5 gui=NONE ctermfg=8 ctermbg=255 cterm=NONE
hi myspecialsymbols guifg=#ff00ff guibg=NONE guisp=NONE gui=NONE ctermfg=201 ctermbg=NONE cterm=NONE
hi browsedirectory guifg=#0000ee guibg=#FFE9E3 guisp=#FFE9E3 gui=NONE ctermfg=21 ctermbg=224 cterm=NONE
hi sql_statement guifg=#9400d3 guibg=NONE guisp=NONE gui=NONE ctermfg=92 ctermbg=NONE cterm=NONE
hi cics_statement guifg=#4e9a06 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi namespace guifg=#006400 guibg=NONE guisp=NONE gui=NONE ctermfg=22 ctermbg=NONE cterm=NONE
hi builtin guifg=#1e90ff guibg=NONE guisp=NONE gui=NONE ctermfg=33 ctermbg=NONE cterm=NONE
hi tablinefillsel guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
"hi normal -- no settings --
hi subtitle guifg=#000000 guibg=#66bbbb guisp=#66bbbb gui=bold,underline ctermfg=NONE ctermbg=73 cterm=bold,underline
hi regexp guifg=#44B4CC guibg=#008b8b guisp=#008b8b gui=NONE ctermfg=74 ctermbg=30 cterm=NONE
hi rubymethod guifg=#DDE93D guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=227 ctermbg=11 cterm=NONE
hi rubynumber guifg=#CCFF33 guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=191 ctermbg=11 cterm=NONE
hi railsuserclass guifg=NONE guibg=NONE guisp=NONE gui=italic ctermfg=NONE ctermbg=NONE cterm=NONE
"hi rubystringdelimiter -- no settings --
hi railsusermethod guifg=NONE guibg=NONE guisp=NONE gui=italic ctermfg=NONE ctermbg=NONE cterm=NONE
