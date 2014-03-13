" If asked to edit something that looks like a perl module name look for it
" with perldoc
au BufReadCmd *::* exe perl#open_module_name( expand("%") )
