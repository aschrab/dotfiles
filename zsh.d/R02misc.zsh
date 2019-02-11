# reset signal handlers
trap -

# Make sure that core files are allowed
unlimit core

# Define a function to find first supported locale out of a list
first_locale () {
  printf %s\\n "$@" |
    fgrep --max-count=1 --ignore-case --line-regexp --file=<(locale -a)
}

export LANG
# The collation order for en_US is awful, ignores . and case
# so, don't use it
export LC_COLLATE=$(first_locale C.UTF{-,}8 C)

# Try to use a locale with more sensible time format than US
export LC_TIME=$(first_locale en_{DK,CA,GB,AU,NZ,IE,US}.UTF{-,}8)

# Make is-at-least function available for use in later config files
autoload -U is-at-least

# Some systems define a `which` alias in /etc/profile.d
unalias -m which
