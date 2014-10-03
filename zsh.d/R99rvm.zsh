# If RVM script is present, source it
#
# Some of its functionality requires that it be run as a shell function

if [[ -d ~/.rbenv/shims ]] && (( $+commands[rbenv] )); then
  eval "$(rbenv init -)"
elif [[ -r ~/.rvm/scripts/rvm ]]; then
  source ~/.rvm/scripts/rvm
fi
