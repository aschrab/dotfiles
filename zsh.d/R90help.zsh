if [ -d /usr/share/zsh/help ]
then
	unalias run-help 2> /dev/null || :
	autoload run-help
	HELPDIR=/usr/share/zsh/help
fi
