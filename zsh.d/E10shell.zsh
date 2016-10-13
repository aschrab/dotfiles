if [[ "$SHELL" != *zsh* ]] && [ -r /proc/$$/exe ]; then
  export SHELL=$(readlink /proc/$$/exe)
fi
