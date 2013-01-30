if exists('g:loaded_surround') && !exists('b:surround_'.char2nr(':'))
  let b:surround_{char2nr(':')} = ":\r"
endif
