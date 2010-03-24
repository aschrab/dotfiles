[[ $ZSH_MAJOR_VERSION -lt 4 ]] && return

# Add a zle widget to kill last N path components
kpathword () {
  local found neg inword post cur=$CURSOR num=$NUMERIC

  if [[ $num -lt 0 ]]
  then
    neg=1
    num=$((num * -1))
  fi

  while [[ $cur -ge 0 ]]
  do
    case $BUFFER[$cur] in
    ' '|'	')
      if [[ $inword -eq 1 ]]
      then
	break
      else
	post="$BUFFER[$cur]$post"
      fi
      ;;
    /)
      found=1
      if [[ "$inword" -eq 1 ]]
      then
	if [[ $((num -= 1)) -le 0 ]]
	then
	  #cur=$((cur - 1))
	  break
	fi
      fi
      ;;
    *)
      inword=1
      ;;
    esac

    cur=$((cur - 1))
  done

  if [[ $found -eq 1 ]]
  then
    if [[ $neg -eq 1 ]]
    then
      LBUFFER="${LBUFFER[0,$cur]}$post"
      #CURSOR=$((CURSOR - $#post))
    else
      #CURSOR=$((cur + 1))
      CURSOR=$cur
    fi
  fi
}

zle -N kpathword
bindkey "\M-/" kpathword
bindkey "\e/" kpathword
bindkey "^[/" kpathword
