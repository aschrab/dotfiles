__delimitmate_quote() {
    if [[ $RBUFFER[1] == "$KEYS" ]] ; then
        RBUFFER=${RBUFFER:1}
    else
        RBUFFER="${KEYS}${RBUFFER}"
    fi
    LBUFFER="${LBUFFER}${KEYS}"
}

__delimitmate_start() {
    case "$KEYS" in
        "{")
            RBUFFER="}${RBUFFER}"
            ;;
        '[')
            RBUFFER="]${RBUFFER}"
            ;;
        '(')
            RBUFFER=")${RBUFFER}"
            ;;
    esac

    LBUFFER="${LBUFFER}${KEYS}"
}

__delimitmate_end() {
    if [[ $RBUFFER[1] == "$KEYS" ]]; then
        RBUFFER=${RBUFFER:1}
    fi
    LBUFFER="${LBUFFER}${KEYS}"
}

__delimitmate_del() {
    local ending
    local prev="${LBUFFER[-1]}"

    if [[ $prev == "'" ]] || [[ $prev == '"' ]] || [[ $prev == '`' ]]
    then
        ending=$prev
    elif [[ $prev == '{' ]]; then
        ending='}'
    elif [[ $prev == '(' ]]; then
        ending=')'
    elif [[ $prev == '[' ]]; then
        ending=']'
    fi

    if [[ -n $ending ]] && [[ $RBUFFER[1] == $ending ]]
    then
        RBUFFER=${RBUFFER:1}
    fi

    zle .backward-delete-char
}

zle -N __delimitmate_quote
zle -N __delimitmate_start
zle -N __delimitmate_end
zle -N backward-delete-char __delimitmate_del
bindmodes emacs,viins __delimitmate_quote \' \" \`
bindmodes emacs,viins __delimitmate_start \{ \[ \(
bindmodes emacs,viins __delimitmate_end   \} \] \)
