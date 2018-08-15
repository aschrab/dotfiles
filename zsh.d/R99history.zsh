HISTFILE=~/.Zhistory
SAVEHIST=$HISTSIZE
setopt inc_append_history
setopt share_history

alias import_history='fc -RI'
alias history_import='fc -RI'

zle-line-init() { zle set-local-history -n 1}
zle -N zle-line-init

zle-global-history-search() {
  zle set-local-history -n 0
  zle .$WIDGET
}
zle -N history-incremental-pattern-search-backward zle-global-history-search
zle -N history-incremental-pattern-search-forward  zle-global-history-search
zle -N history-incremental-search-backward         zle-global-history-search
zle -N history-incremental-search-forward          zle-global-history-search
