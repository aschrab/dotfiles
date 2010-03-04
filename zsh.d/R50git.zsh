parse_git_branch() {
  command git branch --no-color 2> /dev/null | sed -ne '/^\* /s///p'
}

update_git_info() {
  __CURRENT_GIT_BRANCH="$(parse_git_branch)"
}

export __CURRENT_GIT_BRANCH="$(parse_git_branch)"

git() {
  command git "$@"
  update_git_info
}

git_prompt_info() {
  [[ -n "$__CURRENT_GIT_BRANCH" ]] && echo " ($__CURRENT_GIT_BRANCH)"
}

chpwd_functions+='update_git_info'
#preexec_functions+='zsh_preexec_update_git_vars'
