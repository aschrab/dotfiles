" If semicolon is entered as first non-whitespace character in the line
" insert it to the right of the cursor.

function! s:InsertSemicolon()
  let [lnum, col] = searchpos("[])}>\\s]*;\\zs", "nc", line("."))
  if col != 0
    " If there's a following semicolon (possibly after some closing brackets)
    " move the cursor to after it.
    let [buf, curlin, curcol, offs] = getpos(".")
    return repeat("\<Right>", col - curcol)
  elseif search("\\S", "bn", line("."))
    " If there's a preceding non-space character, just insert a semicolon.
    return ';'
  else
    " No preceding non-space characters, so insert and move cursor to before.
    return ";\<Left>"
  endif
endfunction

inoremap <expr> ; <SID>InsertSemicolon()
