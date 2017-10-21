# Disable global RC files if Apple's stupid path helper is found.
# If it's allowed to run it will mangle path ordering.
if [[ -x /usr/libexec/path_helper ]] ; then
  setopt no_global_rcs
fi
