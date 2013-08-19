ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )

() {
  local f=$zshrc_dir/../upstreams/syntax-hightlight/zsh-syntax-highlighting.zsh
  [ -r $f ] && source $f
}
