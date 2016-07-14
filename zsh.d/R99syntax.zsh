ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )

() {
  local f=${zshrc_dir:A}/../upstreams/syntax-highlight/zsh-syntax-highlighting.zsh
  [ -r $f ] && source $f
}
