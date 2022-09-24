__transpose_git_range() {
  emulate -L zsh
  setopt extendedglob
  autoload match-words-by-style

  local curcontext=":zle:$WIDGET" word done
  local -a matched_words
  integer count=${NUMERIC:-1}

  match-words-by-style

  word="$matched_words[2]$matched_words[3]$matched_words[4]$matched_words[5]"

  if [[ $word = *..* ]]; then
    local begin=${word%%(...|..)*}
    local ending=${word##*(...|..)}
    local range=${word%$ending}
    range=${range#$begin}

    BUFFER="$matched_words[0]$matched_words[1]$ending$range$begin$matched_words[6]"
  fi
}

zle -N __transpose_git_range
bindmodes emacs,viins,vicmd __transpose_git_range '^X^T'
