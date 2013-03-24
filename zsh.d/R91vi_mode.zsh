function zle-mode {
  case "$KEYMAP" in
    vicmd)
      echo "%{$fg[red]%}CMD%{$reset_color%}"
      return
      ;;
    viins)
      ;;
    main)
      [[ $(bindkey '\e') == *vi-cmd-mode ]] || return
      ;;
    *)
      return
      ;;
  esac

  echo "%{$fg[green]%}INS%{$reset_color%}"
}

function zle-keymap-select {
  vim_mode=$(zle-mode)
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$(zle-mode)
}
zle -N zle-line-finish

RPS1=' ${vim_mode}'
RPS2=' ${vim_mode}'
setopt transient_rprompt
