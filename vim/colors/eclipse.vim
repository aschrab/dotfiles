" Vim color file - eclipse
" Generated by http://bytefluent.com/vivify 2013-09-12
set background=light
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "eclipse"

hi IncSearch guifg=#404040 guibg=#e0e040 guisp=#e0e040 gui=underline ctermfg=238 ctermbg=185 cterm=underline
hi WildMenu guifg=#f8f8f8 guibg=#ff3030 guisp=#ff3030 gui=NONE ctermfg=15 ctermbg=13 cterm=NONE
"hi SignColumn -- no settings --
hi SpecialComment guifg=#8040f0 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=13 ctermbg=15 cterm=NONE
hi Typedef guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
hi Title guifg=#0033cc guibg=#ffffff guisp=#ffffff gui=bold ctermfg=26 ctermbg=15 cterm=bold
hi Folded guifg=#804030 guibg=#fff0d0 guisp=#fff0d0 gui=bold ctermfg=3 ctermbg=230 cterm=bold
hi PreCondit guifg=#683821 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=52 ctermbg=15 cterm=NONE
hi Include guifg=#683821 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=52 ctermbg=15 cterm=NONE
"hi TabLineSel -- no settings --
hi StatusLineNC guifg=#ffffff guibg=#75a0da guisp=#75a0da gui=NONE ctermfg=15 ctermbg=110 cterm=NONE
"hi CTagsMember -- no settings --
hi NonText guifg=#707070 guibg=#e7e7e7 guisp=#e7e7e7 gui=NONE ctermfg=242 ctermbg=254 cterm=NONE
"hi CTagsGlobalConstant -- no settings --
hi DiffText guifg=#ff0000 guibg=#ffd0d0 guisp=#ffd0d0 gui=bold ctermfg=196 ctermbg=224 cterm=bold
hi ErrorMsg guifg=#f8f8f8 guibg=#4040ff guisp=#4040ff gui=NONE ctermfg=15 ctermbg=13 cterm=NONE
hi Ignore guifg=#ffffff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=15 ctermbg=15 cterm=NONE
hi Debug guifg=#8040f0 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=13 ctermbg=15 cterm=NONE
hi PMenuSbar guifg=#ffffff guibg=#ff0000 guisp=#ff0000 gui=NONE ctermfg=15 ctermbg=196 cterm=NONE
hi Identifier guifg=#b07800 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=136 ctermbg=15 cterm=NONE
hi SpecialChar guifg=#8040f0 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=13 ctermbg=15 cterm=NONE
"hi Conditional -- no settings --
hi StorageClass guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
hi Todo guifg=#ff5050 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=203 ctermbg=15 cterm=NONE
hi Special guifg=#8040f0 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=13 ctermbg=15 cterm=NONE
hi LineNr guifg=#6b6b6b guibg=#eeeeee guisp=#eeeeee gui=NONE ctermfg=242 ctermbg=255 cterm=NONE
hi StatusLine guifg=#ffffff guibg=#4570aa guisp=#4570aa gui=bold ctermfg=15 ctermbg=67 cterm=bold
hi Normal guifg=#000000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
hi Label guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
"hi CTagsImport -- no settings --
hi PMenuSel guifg=#000000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
hi Search guifg=#544060 guibg=#f0c0ff guisp=#f0c0ff gui=NONE ctermfg=59 ctermbg=219 cterm=NONE
"hi CTagsGlobalVariable -- no settings --
hi Delimiter guifg=#000000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
hi Statement guifg=#b64f90 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=132 ctermbg=15 cterm=NONE
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
hi Comment guifg=#236e25 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=22 ctermbg=15 cterm=NONE
hi Character guifg=#00884c guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=29 ctermbg=15 cterm=NONE
hi Float guifg=#0000ff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=21 ctermbg=15 cterm=NONE
hi Number guifg=#0000ff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=21 ctermbg=15 cterm=NONE
hi Boolean guifg=#b64f90 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=132 ctermbg=15 cterm=NONE
hi Operator guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
"hi CursorLine -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
hi Question guifg=#8000ff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=93 ctermbg=15 cterm=NONE
hi WarningMsg guifg=#f8f8f8 guibg=#4040ff guisp=#4040ff gui=NONE ctermfg=15 ctermbg=13 cterm=NONE
"hi VisualNOS -- no settings --
hi DiffDelete guifg=#ffffff guibg=#e7e7ff guisp=#e7e7ff gui=NONE ctermfg=15 ctermbg=189 cterm=NONE
hi ModeMsg guifg=#d06000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=166 ctermbg=15 cterm=NONE
"hi CursorColumn -- no settings --
hi Define guifg=#683821 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=52 ctermbg=15 cterm=NONE
hi Function guifg=#b07800 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=136 ctermbg=15 cterm=NONE
hi FoldColumn guifg=#6b6b6b guibg=#e7e7e7 guisp=#e7e7e7 gui=NONE ctermfg=242 ctermbg=254 cterm=NONE
hi PreProc guifg=#683821 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=52 ctermbg=15 cterm=NONE
"hi EnumerationName -- no settings --
hi Visual guifg=#804020 guibg=#ffc0a0 guisp=#ffc0a0 gui=NONE ctermfg=3 ctermbg=223 cterm=NONE
hi MoreMsg guifg=#0090a0 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=37 ctermbg=15 cterm=NONE
"hi SpellCap -- no settings --
hi VertSplit guifg=#f8f8f8 guibg=#904838 guisp=#904838 gui=NONE ctermfg=15 ctermbg=95 cterm=NONE
hi Exception guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
hi Keyword guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
hi Type guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
hi DiffChange guifg=#000000 guibg=#ffe7e7 guisp=#ffe7e7 gui=NONE ctermfg=NONE ctermbg=224 cterm=NONE
hi Cursor guifg=#ffffff guibg=#0080f0 guisp=#0080f0 gui=NONE ctermfg=15 ctermbg=33 cterm=NONE
"hi SpellLocal -- no settings --
hi Error guifg=#f8f8f8 guibg=#4040ff guisp=#4040ff gui=NONE ctermfg=15 ctermbg=13 cterm=NONE
hi PMenu guifg=#ffffff guibg=#00ff00 guisp=#00ff00 gui=NONE ctermfg=15 ctermbg=10 cterm=NONE
hi SpecialKey guifg=#c0c0c0 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=7 ctermbg=15 cterm=NONE
hi Constant guifg=#00884c guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=29 ctermbg=15 cterm=NONE
"hi DefinedName -- no settings --
hi Tag guifg=#8040f0 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=13 ctermbg=15 cterm=NONE
hi String guifg=#8010a0 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=91 ctermbg=15 cterm=NONE
hi PMenuThumb guifg=#ff0000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=196 ctermbg=15 cterm=NONE
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
hi Repeat guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
hi Directory guifg=#7050ff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=99 ctermbg=15 cterm=NONE
hi Structure guifg=#7f0055 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=89 ctermbg=15 cterm=bold
hi Macro guifg=#683821 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=52 ctermbg=15 cterm=NONE
hi Underlined guifg=#0000ff guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=21 ctermbg=15 cterm=NONE
hi DiffAdd guifg=#0000ff guibg=#e7e7ff guisp=#e7e7ff gui=bold ctermfg=21 ctermbg=189 cterm=bold
"hi TabLine -- no settings --
hi cursorim guifg=#ffffff guibg=#8040ff guisp=#8040ff gui=NONE ctermfg=15 ctermbg=13 cterm=NONE
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
hi lcursor guifg=#ffffff guibg=#8040ff guisp=#8040ff gui=NONE ctermfg=15 ctermbg=13 cterm=NONE
hi doxygenspecialmultilinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi taglisttagname guifg=#808bed guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
hi doxygenbrief guifg=#fdab60 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi mbevisiblenormal guifg=#cfcfcd guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=252 ctermbg=60 cterm=NONE
hi user2 guifg=#7070a0 guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=103 ctermbg=60 cterm=NONE
hi user1 guifg=#00ff8b guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=48 ctermbg=60 cterm=NONE
hi doxygenspecialonelinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi doxygencomment guifg=#ad7b20 guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi cspecialcharacter guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi htmlitalic guifg=#000000 guibg=#ffffff guisp=#ffffff gui=italic ctermfg=NONE ctermbg=15 cterm=NONE
hi htmlboldunderlineitalic guifg=#000000 guibg=#ffffff guisp=#ffffff gui=bold,italic,underline ctermfg=NONE ctermbg=15 cterm=bold,underline
hi htmlbolditalic guifg=#000000 guibg=#ffffff guisp=#ffffff gui=bold,italic ctermfg=NONE ctermbg=15 cterm=bold
hi kde guifg=#ff00ff guibg=NONE guisp=NONE gui=NONE ctermfg=201 ctermbg=NONE cterm=NONE
hi browsefile guifg=#000080 guibg=#E3EFFF guisp=#E3EFFF gui=NONE ctermfg=18 ctermbg=189 cterm=NONE
hi browsecurdirectory guifg=#8b0000 guibg=#FFE9E3 guisp=#FFE9E3 gui=NONE ctermfg=88 ctermbg=224 cterm=NONE
hi htmlunderlineitalic guifg=#000000 guibg=#ffffff guisp=#ffffff gui=italic,underline ctermfg=NONE ctermbg=15 cterm=underline
hi htmlbold guifg=#000000 guibg=#ffffff guisp=#ffffff gui=bold ctermfg=NONE ctermbg=15 cterm=bold
hi htmlboldunderline guifg=#000000 guibg=#ffffff guisp=#ffffff gui=bold,underline ctermfg=NONE ctermbg=15 cterm=bold,underline
hi htmlunderline guifg=#000000 guibg=#ffffff guisp=#ffffff gui=underline ctermfg=NONE ctermbg=15 cterm=underline
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
