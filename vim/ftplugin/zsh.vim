setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

if exists("loaded_matchit")
  if !exists("b:match_words")
    let s:sol = '\%(;\s*\|^\s*\)\@<='  " start of line
    let b:match_words =
      \ s:sol.'if\>:' . s:sol.'elif\>:' . s:sol.'else\>:' . s:sol. 'fi\>,' .
      \ s:sol.'\%(for\|while\)\>:' . s:sol. 'done\>,' .
      \ s:sol.'case\>:' . s:sol. 'esac\>' .
      \ ',(:),{:},\[:]'
  endif
endif
