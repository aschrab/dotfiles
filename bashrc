PS1='\[\e]2;\$\h(\l):\w\a\]''\n''\[\e[0;45m\]'' \D{%d%b%H:%M:%S} \h \w ''\n''\[\e[0;45m\]''\!\$''\[\e[0;22m\] '

alias l='ls -F'
alias g=git

set -o noclobber

shopt -s autocd cdspell dirspell extglob

# The following breaks completion
#shopt -s failglob
