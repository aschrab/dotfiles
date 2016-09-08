[ -n "$PS1" ] && PS1='\[\e]2;\$\h(\l):\w\a\]''\n''\[\e[0;45m\]'' \D{%d%b%H:%M:%S} \h \w \[\e[0;22m\]''\n''\[\e[0;45m\]''\!\$''\[\e[0;22m\] '

alias l='ls -F'
alias ll='l -l'
alias la='l -a'
alias lla='ll -a'

alias g=git

set -o noclobber

shopt -s autocd cdspell dirspell extglob 2> /dev/null

# The following breaks completion
#shopt -s failglob
