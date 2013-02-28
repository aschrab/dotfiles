# reset signal handlers
trap -

# Make sure that core files are allowed
unlimit core

# The collation order for en_US is awful, ignores . and case
# so, don't use it
export LANG LC_COLLATE="C"

# Make is-at-least function available for use in later config files
autoload -U is-at-least
