autoload -Uz narrow-to-region
function _history-incremental-preserving-pattern-search-backward
{
  local state
  MARK=CURSOR  # magick, else multiple ^R don't work
  narrow-to-region -p "$LBUFFER${BUFFER:+»}" -P "${BUFFER:+«}$RBUFFER" -S state
  zle end-of-history
  if zle fzf-history-widget ; then
    zle fzf-history-widget
  else
    zle .history-incremental-pattern-search-backward
  fi
  narrow-to-region -R state
}
zle -N _history-incremental-preserving-pattern-search-backward
bindkey -M viins "^R" _history-incremental-preserving-pattern-search-backward
bindkey -M isearch "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
