() {
  local f
  for f in "$zshrc_dir"/plugins/*/*.plugin.zsh(#qN)
  do
    source "$f"
  done
}
