HELPDIR=${${module_path[1]%/*}/\/lib\//\/share\/}/help
if [[ -d $HELPDIR ]]
then
	unalias run-help 2> /dev/null || :
	autoload run-help
	autoload run-help-git
	autoload run-help-svn
	autoload run-help-sudo
fi
