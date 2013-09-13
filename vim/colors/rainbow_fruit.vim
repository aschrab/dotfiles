" Vim color file - rainbow_fruit
" Generated by http://bytefluent.com/vivify 2013-09-12
set background=light
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "rainbow_fruit"

hi IncSearch guifg=#404040 guibg=#40ffff guisp=#40ffff gui=NONE ctermfg=238 ctermbg=87 cterm=NONE
hi WildMenu guifg=#f8f8f8 guibg=#ff4080 guisp=#ff4080 gui=NONE ctermfg=15 ctermbg=13 cterm=NONE
"hi SignColumn -- no settings --
hi SpecialComment guifg=#4a9400 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Typedef guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
hi Title guifg=#0050a0 guibg=#c0e8ff guisp=#c0e8ff gui=NONE ctermfg=25 ctermbg=153 cterm=NONE
hi Folded guifg=#20605c guibg=#b8e8dc guisp=#b8e8dc gui=NONE ctermfg=23 ctermbg=152 cterm=NONE
hi PreCondit guifg=#e06800 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi Include guifg=#e06800 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
"hi TabLineSel -- no settings --
hi StatusLineNC guifg=#a4a4a4 guibg=#404040 guisp=#404040 gui=NONE ctermfg=248 ctermbg=238 cterm=NONE
"hi CTagsMember -- no settings --
hi NonText guifg=#00a0c0 guibg=#ececec guisp=#ececec gui=NONE ctermfg=4 ctermbg=255 cterm=NONE
"hi CTagsGlobalConstant -- no settings --
hi DiffText guifg=#e04040 guibg=#ffd8d8 guisp=#ffd8d8 gui=NONE ctermfg=167 ctermbg=224 cterm=NONE
hi ErrorMsg guifg=#ff0000 guibg=#ffe4e4 guisp=#ffe4e4 gui=NONE ctermfg=196 ctermbg=224 cterm=NONE
hi Ignore guifg=#f8f8f8 guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi Debug guifg=#4a9400 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
"hi PMenuSbar -- no settings --
hi Identifier guifg=#008888 guibg=NONE guisp=NONE gui=NONE ctermfg=30 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#4a9400 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Conditional guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
hi Todo guifg=#ff0070 guibg=#ffe0f4 guisp=#ffe0f4 gui=NONE ctermfg=197 ctermbg=225 cterm=NONE
hi Special guifg=#4a9400 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi LineNr guifg=#acacac guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#f8f8f8 guibg=#404040 guisp=#404040 gui=NONE ctermfg=15 ctermbg=238 cterm=NONE
hi Normal guifg=#404040 guibg=#f8f8f8 guisp=#f8f8f8 gui=NONE ctermfg=238 ctermbg=15 cterm=NONE
hi Label guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#f8f8f8 guibg=#404040 guisp=#404040 gui=NONE ctermfg=15 ctermbg=238 cterm=NONE
hi Search guifg=#404040 guibg=#ffff60 guisp=#ffff60 gui=NONE ctermfg=238 ctermbg=227 cterm=NONE
"hi CTagsGlobalVariable -- no settings --
hi Delimiter guifg=#4a9400 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi Statement guifg=#f030d0 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
hi Comment guifg=#ff4080 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi Character guifg=#8016ff guibg=NONE guisp=NONE gui=NONE ctermfg=93 ctermbg=NONE cterm=NONE
"hi Float -- no settings --
hi Number guifg=#8016ff guibg=NONE guisp=NONE gui=NONE ctermfg=93 ctermbg=NONE cterm=NONE
hi Boolean guifg=#f030d0 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi Operator guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
"hi CursorLine -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
hi Question guifg=#f030d0 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi WarningMsg guifg=#ff0000 guibg=#ffe4e4 guisp=#ffe4e4 gui=NONE ctermfg=196 ctermbg=224 cterm=NONE
"hi VisualNOS -- no settings --
hi DiffDelete guifg=#4848ff guibg=#ffd0ff guisp=#ffd0ff gui=NONE ctermfg=63 ctermbg=225 cterm=NONE
hi ModeMsg guifg=#ff4080 guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
"hi CursorColumn -- no settings --
hi Define guifg=#e06800 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi Function guifg=#008888 guibg=NONE guisp=NONE gui=NONE ctermfg=30 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=#40a098 guibg=#f0f0f0 guisp=#f0f0f0 gui=NONE ctermfg=73 ctermbg=255 cterm=NONE
hi PreProc guifg=#e06800 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
"hi EnumerationName -- no settings --
hi Visual guifg=#484848 guibg=#e0e0e0 guisp=#e0e0e0 gui=NONE ctermfg=238 ctermbg=254 cterm=NONE
hi MoreMsg guifg=#009070 guibg=NONE guisp=NONE gui=NONE ctermfg=29 ctermbg=NONE cterm=NONE
"hi SpellCap -- no settings --
hi VertSplit guifg=#f8f8f8 guibg=#404040 guisp=#404040 gui=NONE ctermfg=15 ctermbg=238 cterm=NONE
hi Exception guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
hi Keyword guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
hi Type guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
hi DiffChange guifg=#408040 guibg=#d0f0d0 guisp=#d0f0d0 gui=NONE ctermfg=65 ctermbg=194 cterm=NONE
hi Cursor guifg=#0000ff guibg=#00e0ff guisp=#00e0ff gui=NONE ctermfg=21 ctermbg=45 cterm=NONE
"hi SpellLocal -- no settings --
hi Error guifg=#ffffff guibg=#ff4080 guisp=#ff4080 gui=NONE ctermfg=15 ctermbg=13 cterm=NONE
hi PMenu guifg=#a4a4a4 guibg=#404040 guisp=#404040 gui=NONE ctermfg=248 ctermbg=238 cterm=NONE
hi SpecialKey guifg=#4040ff guibg=NONE guisp=NONE gui=NONE ctermfg=13 ctermbg=NONE cterm=NONE
hi Constant guifg=#8016ff guibg=NONE guisp=NONE gui=NONE ctermfg=93 ctermbg=NONE cterm=NONE
"hi DefinedName -- no settings --
hi Tag guifg=#4a9400 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi String guifg=#8016ff guibg=NONE guisp=NONE gui=NONE ctermfg=93 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#acacac guisp=#acacac gui=NONE ctermfg=NONE ctermbg=145 cterm=NONE
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
hi Repeat guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
hi Directory guifg=#0070b8 guibg=NONE guisp=NONE gui=NONE ctermfg=25 ctermbg=NONE cterm=NONE
hi Structure guifg=#0070e6 guibg=NONE guisp=NONE gui=NONE ctermfg=26 ctermbg=NONE cterm=NONE
hi Macro guifg=#e06800 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi Underlined guifg=#404040 guibg=NONE guisp=NONE gui=NONE ctermfg=238 ctermbg=NONE cterm=NONE
hi DiffAdd guifg=#4848ff guibg=#ffd0ff guisp=#ffd0ff gui=NONE ctermfg=63 ctermbg=225 cterm=NONE
"hi TabLine -- no settings --
hi cursorim guifg=#f8f8f8 guibg=#8000ff guisp=#8000ff gui=NONE ctermfg=15 ctermbg=93 cterm=NONE
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
hi lcursor guifg=#f8f8f8 guibg=#8000ff guisp=#8000ff gui=NONE ctermfg=15 ctermbg=93 cterm=NONE
hi doxygenspecialmultilinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi taglisttagname guifg=#808bed guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
hi doxygenbrief guifg=#fdab60 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi mbevisiblenormal guifg=#cfcfcd guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=252 ctermbg=60 cterm=NONE
hi user2 guifg=#7070a0 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=103 ctermbg=60 cterm=NONE
hi user1 guifg=#00ff8b guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=48 ctermbg=60 cterm=NONE
hi doxygenspecialonelinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi doxygencomment guifg=#ad7b20 guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi cspecialcharacter guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi htmlitalic guifg=NONE guibg=NONE guisp=NONE gui=italic ctermfg=NONE ctermbg=NONE cterm=NONE
hi htmlboldunderlineitalic guifg=NONE guibg=NONE guisp=NONE gui=bold,italic,underline ctermfg=NONE ctermbg=NONE cterm=bold,underline
hi htmlbolditalic guifg=NONE guibg=NONE guisp=NONE gui=bold,italic ctermfg=NONE ctermbg=NONE cterm=bold
hi kde guifg=#ff00ff guibg=NONE guisp=NONE gui=NONE ctermfg=201 ctermbg=NONE cterm=NONE
hi browsefile guifg=#000080 guibg=#E3EFFF guisp=#E3EFFF gui=NONE ctermfg=18 ctermbg=189 cterm=NONE
hi browsecurdirectory guifg=#8b0000 guibg=#FFE9E3 guisp=#FFE9E3 gui=NONE ctermfg=88 ctermbg=224 cterm=NONE
hi htmlunderlineitalic guifg=NONE guibg=NONE guisp=NONE gui=italic,underline ctermfg=NONE ctermbg=NONE cterm=underline
hi htmlbold guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi htmlboldunderline guifg=NONE guibg=NONE guisp=NONE gui=bold,underline ctermfg=NONE ctermbg=NONE cterm=bold,underline
hi htmlunderline guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
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
"hi default -- no settings --
hi pythonstatement guifg=#4e9a06 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi menu guifg=#000000 guibg=#d3d3d3 guisp=#d3d3d3 gui=NONE ctermfg=NONE ctermbg=252 cterm=NONE
hi pythonimport guifg=#9700cc guibg=NONE guisp=NONE gui=NONE ctermfg=128 ctermbg=NONE cterm=NONE
hi pythonbuiltin guifg=#5181ab guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi pythonoperator guifg=#ef2929 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi pythoncomment guifg=#0066ff guibg=NONE guisp=NONE gui=NONE ctermfg=27 ctermbg=NONE cterm=NONE
hi pythonprecondit guifg=#ef2929 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi pythonrawstring guifg=#ad7fa8 guibg=NONE guisp=NONE gui=NONE ctermfg=139 ctermbg=NONE cterm=NONE
hi pythonconditional guifg=#d28202 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi pythonrepeat guifg=#4e9a06 guibg=NONE guisp=NONE gui=NONE ctermfg=64 ctermbg=NONE cterm=NONE
hi comments guifg=#0066ff guibg=NONE guisp=NONE gui=NONE ctermfg=27 ctermbg=NONE cterm=NONE
hi constants guifg=#6782d3 guibg=NONE guisp=NONE gui=NONE ctermfg=68 ctermbg=NONE cterm=NONE
hi preconduit guifg=#702589 guibg=NONE guisp=NONE gui=underline ctermfg=54 ctermbg=NONE cterm=underline
hi vcursor guifg=#ffffff guibg=#efface guisp=#efface gui=NONE ctermfg=15 ctermbg=230 cterm=NONE
hi scrollbar guifg=#d3d3d3 guibg=#a9a9a9 guisp=#a9a9a9 gui=NONE ctermfg=252 ctermbg=248 cterm=NONE
hi tooltip guifg=#000000 guibg=#d3d3d3 guisp=#d3d3d3 gui=NONE ctermfg=NONE ctermbg=252 cterm=NONE
hi ccursor guifg=#ffffff guibg=#8b0000 guisp=#8b0000 gui=NONE ctermfg=15 ctermbg=88 cterm=NONE
hi ocursor guifg=#ffffff guibg=#008b8b guisp=#008b8b gui=NONE ctermfg=15 ctermbg=30 cterm=NONE
hi unitheader guifg=#000000 guibg=#add8e6 guisp=#add8e6 gui=bold ctermfg=NONE ctermbg=152 cterm=bold
hi io guifg=#ff0000 guibg=NONE guisp=NONE gui=bold ctermfg=196 ctermbg=NONE cterm=bold
hi communicator guifg=#000000 guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=NONE ctermbg=11 cterm=NONE
