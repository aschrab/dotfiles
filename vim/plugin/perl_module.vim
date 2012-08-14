" If asked to edit something that looks like a perl module name look for it
" with perldoc
"au BufReadCmd *::* exe ":silent 1,$!cat `perldoc -l %`" | setlocal buftype=nofile ft=perl
