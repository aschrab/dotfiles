ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )

() {
  local f
  for f in ${zshrc_dir:A}/../upstreams/syntax-highlight/{{fast,zsh}-syntax-highlighting,F-Sy-H}{,.plugin}.zsh
  do
    if [ -r $f ]; then
      source $f
      return
    fi
  done
}
