if exists(':Alias')
  let g:cmdaliasCmdPrefixes .= ' vert'

  Alias ack Ack
  Alias New new
  Alias gitk Flog
  Alias gv Flog
  Alias scratch Scratch
  if exists(':Shell')
    Alias sh    Shell
    Alias shell Shell
    Alias SHell Shell
  endif

  if exists(':Man')
    Alias man Man
  endif

  Alias Gmv GMove
  Alias Grm GRemove
  Alias Gci Git\ commit
  Alias Gpush Git\ push

  Alias Rm Delete
  Alias Mv Move
  Alias rm Delete
  Alias mv Move

  Alias weq wq
  Alias Wq wq
endif
