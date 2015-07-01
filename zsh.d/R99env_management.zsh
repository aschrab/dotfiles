if [[ -x ~/.rbenv/bin/rbenv ]] && [[ -d ~/.rbenv/shims ]]; then
  path+=(~/.rbenv/bin)
  eval "$(rbenv init -)"

  if (( $+commands[brew] )); then
    export RUBY_CONFIGURE_OPTS="--with-readline-dir=`brew --prefix readline`"
    #RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --with-openssl-dir=`brew --prefix openssl`"
    #RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --with-libyaml-dir=`brew --prefix libyaml`"
  fi
elif [[ -r ~/.rvm/scripts/rvm ]]; then
  source ~/.rvm/scripts/rvm
fi

if [[ -x ~/.ndenv/bin/ndenv ]] && [[ -d ~/.ndenv/shims ]]; then
  path+=(~/.ndenv/bin)
  eval "$(ndenv init -)"
fi

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
