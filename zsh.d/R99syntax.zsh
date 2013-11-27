ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )

() {
  local f=$zshrc_dir/../upstreams/syntax-highlight/zsh-syntax-highlighting.zsh
  [ -r $f ] && source $f
}
