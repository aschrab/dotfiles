if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal indentkeys=o,O,<>>,<<>,/
setlocal indentexpr=GetApacheStyleIndent()

if exists("*GetApacheStyleIndent")
  finish
endif

function GetApacheStyleIndent()
  let prev = prevnonblank(v:lnum - 1)

  " Use 0 indent at start of file
  if prev == 0
    return 0
  endif

  " Start with indent of previous line
  let ind = indent(prev)

  let sw = &shiftwidth
  if sw == 0
    let sw = &tabstop
  endif

  " Add shiftwidth if previous line started a section
  if getline(prev) =~ '^\s*<[^/]'
    let ind = ind + sw
  endif

  " Subtract shiftwidth if this line ends a section
  if getline(v:lnum) =~ '^\s*</'
    let ind = ind - sw
  endif

  return ind
endfunction
