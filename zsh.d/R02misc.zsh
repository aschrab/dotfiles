# reset signal handlers
trap -

# Make sure that core files are allowed
unlimit core

export LANG
# The collation order for en_US is awful, ignores . and case
# so, don't use it
() {
  local loc
  for loc in C.UTF-8 C.UTF8 C; do
    if locale -a | fgrep --ignore-case --line-regexp --quiet $loc; then
      export LC_COLLATE=$loc
      return
    fi
  done
}

# Make is-at-least function available for use in later config files
autoload -U is-at-least
