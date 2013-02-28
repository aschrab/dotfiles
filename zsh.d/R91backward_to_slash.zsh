is-at-least 4.0 || return

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
bindkey -M emacs "\M-/" backward-to-/
bindkey -M emacs "\e/" backward-to-/
bindkey -M emacs "^[/" backward-to-/
