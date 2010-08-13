[[ $ZSH_MAJOR_VERSION -lt 4 ]] && return

# Copied from http://zshwiki.org/home/examples/zlewordchar

function is_quoted(){
 test "${BUFFER[$CURSOR-1,CURSOR-1]}" = "\\"
}

unquote-backward-word(){
    while  is_quoted
      do zle .backward-word
    done
}

# Add a zle widget to kill last N path components
backward-to-/ () {
  local WORDCHARS='*?_-.[]~=&;!#$%^(){}<>:@,\\'
  zle .backward-word
  unquote-backward-word
}

zle -N backward-to-/
bindkey "\M-/" backward-to-/
bindkey "\e/" backward-to-/
bindkey "^[/" backward-to-/
