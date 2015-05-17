# If RVM script is present, source it
#
# Some of its functionality requires that it be run as a shell function

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
