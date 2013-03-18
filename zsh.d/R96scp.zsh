# Disable automatic globbing for arguments to scp
alias scp='noglob scp'

# Examine arguments to scp, and do explicit globbing for any that aren't
# options or references to remote paths
#
# Idea inspired by post to zsh-users mailing list by Peter Stephenson:
#   http://www.zsh.org/mla/users/2010/msg00745.html
'scp'() {
  local arg
  local -a args
  for arg in $argv
  do
    case "$arg" in
    -*|*:*)
      # Use argument verbatim
      args=($args "$arg")
      ;;
    *)
      # Do glob expansion
      args=($args ${~arg})
      ;;
    esac
  done

  command scp $args
}
