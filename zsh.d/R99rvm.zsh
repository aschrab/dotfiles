# If RVM script is present, source it
#
# Some of its functionality requires that it be run as a shell function

[[ -r ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

# Add RVM bin directory to path
[[ -d ~/.rvm/bin ]] && path=( $path ~/.rvm/bin )