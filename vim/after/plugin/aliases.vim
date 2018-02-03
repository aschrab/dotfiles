if exists(":Alias")
  Alias ack Ack
  Alias New new
  Alias gitk Gitv
  Alias gv Gitv
  Alias scratch Scratch
  if exists(":Shell")
    Alias shell Shell
    Alias SHell Shell
  endif

  if exists(":Man")
    Alias man Man
  endif

  Alias Gmv Gmove
  Alias Grm Gremove
  Alias Gci Gcommit

  Alias Rm Delete
  Alias Mv Move
  Alias rm Delete
  Alias mv Move
endif
