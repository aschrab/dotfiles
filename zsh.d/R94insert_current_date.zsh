_ins_current_date() {
  local fmt
  if [[ ${+NUMERIC} == 1 ]]
  then
    fmt='%Y-%m-%d'
  else
    fmt='%Y%m%d'
  fi
  LBUFFER+=$(print -n -P "%D{$fmt}")
}

zle -N _ins_current_date
bindkey -M emacs '\M-N' _ins_current_date
bindkey -M emacs  '\eN' _ins_current_date
