if [ -d /usr/share/zsh/help ]
then
	unalias run-help 2> /dev/null || :
	autoload run-help
	autoload run-help-git
	autoload run-help-svn
	autoload run-help-sudo
	HELPDIR=/usr/share/zsh/help
fi
