__link_dir() {
  local linkpath=$(perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' $1)
	[[ -n $linkpath ]] && dirname $linkpath
}

zshrc_dir=~/.zsh.d
[[ -d $zshrc_dir ]] || zshrc_dir=$( __link_dir ~/.zshrc )/zsh.d
[[ -d $zshrc_dir ]] || zshrc_dir=~${SUDO_USER}/.zsh.d
[[ -d $zshrc_dir ]] || zshrc_dir=$( __link_dir ~${SUDO_USER}/.zshrc )/zsh.d

unfunction __link_dir

case "$zshrc_dir" in
  /*)
    ;;
  *)
    zshrc_dir="$HOME/$zshrc_dir"
    ;;
esac

for zshrc_snipplet in $zshrc_dir/E[0-9][0-9]*.zsh ; do
  source $zshrc_snipplet
done
