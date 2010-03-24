if [[ -z $(whence git) ]]; then
  zgit_current_branch() {
  }
else
  zgit_current_branch() {
    local branch=$(git symbolic-ref HEAD 2> /dev/null)
    if [[ -n $branch ]] && echo " [${branch##*/}]"
  }
fi
