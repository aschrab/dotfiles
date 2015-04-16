if [[ -x ~/.ndenv/bin/ndenv ]] && [[ -d ~/.ndenv/shims ]]; then
  path+=(~/.ndenv/bin)
  eval "$(ndenv init -)"
fi
