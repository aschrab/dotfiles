if [[ -x ~/.rbenv/bin/rbenv ]]; then
  rbenv_setup() {
    path=(~/.rbenv/bin $path)
    eval "$(rbenv init -)"
    unfunction rbenv_setup
  }
  [[ -d ~/.rbenv/shims ]] && rbenv_setup

  if (( $+commands[brew] )); then
    # export RUBY_CONFIGURE_OPTS="--with-readline-dir=`brew --prefix readline`"
    export RUBY_CONFIGURE_OPTS="--with-readline-dir=/usr/local/opt/readline"
    #RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --with-openssl-dir=`brew --prefix openssl`"
    #RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --with-libyaml-dir=`brew --prefix libyaml`"
  fi
elif [[ -r ~/.rvm/scripts/rvm ]]; then
  unfunction rbenv_setup 2>/dev/null # Switching isn't this simple
  source ~/.rvm/scripts/rvm
fi

if [[ -x ~/.ndenv/bin/ndenv ]]; then
  ndenv_setup() {
    path+=(~/.ndenv/bin)
    eval "$(ndenv init -)"
    unfunction ndenv_setup
  }
  [[ -d ~/.ndenv/shims ]] && ndenv_setup
fi

(( $+commands[direnv] )) && eval "$(direnv hook zsh)" && direnv reload 2>/dev/null
