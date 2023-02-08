if (( $+commands[ag] )) ; then
  export FZF_DEFAULT_COMMAND='ag -l'
  export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
fi
export FZF_TMUX=1

() {
  (( $+commands[tmux] )) || return
  local version=$(tmux -V)
  if is-at-least 3.2 ${version#tmux }
  then
    export FZF_TMUX_OPTS=-p
  fi

  local fzf f
  for fzf in /usr/local/opt/fzf/shell /usr/share/doc/fzf/examples
  do
    if [ -d "$fzf" ]; then
      for f in key-bindings completion
      do
        if [ -r "$fzf/$f.zsh" ]; then
          source "$fzf/$f.zsh"
        fi
      done
      break
    fi
  done
}

bindmodes emacs,viins fzf-file-widget '^F'
