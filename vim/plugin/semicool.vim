" If semicolon is entered as first non-whitespace character in the line
" insert it to the right of the cursor.
inoremap <expr> ; (search("\\S", "bn", line(".")) ? ";" : ";<left>")
