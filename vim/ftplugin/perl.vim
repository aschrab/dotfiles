setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab

map ,= mzgg/Test::More tests =><CR><C-a>`z
map ,- mzgg/Test::More tests =><CR><C-x>`z

compiler perlcritic
