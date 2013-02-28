is-at-least 4.0 || return

# Change behaviour of insert-last-word widget
# $NUMERIC should be carried over between consecutive invocations
ins-last-word () {
  #echo $LASTWIDGET
  if [[ ${+NUMERIC} == 1 ]]
  then
    insertlastwordsavenumeric=$NUMERIC
  fi

  if [[ $LASTWIDGET == insert-last-word ]]
  then
    if [[ ${+insertlastwordsavenumeric} == 1 ]]
    then
      NUMERIC=${insertlastwordsavenumeric}
    fi
  else
    [[ ${+NUMERIC} == 1 ]] || unset insertlastwordsavenumeric
  fi

  zle .insert-last-word
}

zle -N insert-last-word ins-last-word
