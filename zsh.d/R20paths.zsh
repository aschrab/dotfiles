typeset -aU fpath
fpath=(
  $zshrc_dir/completion
  $fpath
  /usr/share/zsh/vendor-completions/
  $zshrc_dir/../upstreams/completions/src/
  /usr/local/share/zsh/site-functions/
  /usr/share/zsh/site-functions/
  /usr/local/share/zsh/functions/
)

() {
  local fdir
  local fpaths=()
  for fdir in "$@" ; do
    fpaths+=$fdir
    [ -d "$fdir" ] && autoload -- $fdir/*(:t)
  done
  fpath=($fpaths $fpath)
} "$zshrc_dir/functions" "${ZDOTDIR:-$HOME}/.functions"

path+=$(dirname $(perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' $zshrc_dir))/upstreams/powerline/scripts/
