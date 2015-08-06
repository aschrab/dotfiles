for HELPDIR in ${${module_path[1]%/*}/\/lib\//\/share\/}/help /usr{,/local}/share/zsh{/$ZSH_VERSION,}/help
do
	[[ -d $HELPDIR ]] || continue
	unalias run-help 2> /dev/null || :
	autoload run-help
	autoload run-help-git
	autoload run-help-svn
	autoload run-help-sudo
	break
done
