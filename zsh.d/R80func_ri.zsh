if [[ -n "$(whence ri1.8)" ]]; then
  function ___ri () {
    # Locally tell less to:
    #   -F: quit if the entire file fits on the screen
    #   -f: not complain about binary files
    #   -R: pass through terminal control characters
    local -x LESS="${LESS:?-}FfR"
    ri1.8 -fansi "$@"
  }
  # Turn off globbing for arguments to ri, since glob characters are
  # common in names of ruby methods
  alias ri='noglob ___ri'
fi
