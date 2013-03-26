bindkey -v

bindmodes emacs,viins,vicmd up-line-or-search '\e[A' '\eOA' # Up arrow
bindmodes emacs,viins,vicmd backward-word '\e[5D' '\e[1;5D' # ctrl + left-arrow
bindmodes emacs,viins,vicmd forward-word  '\e[5C' '\e[1;5C' # ctrl + right-arrow

bindmodes emacs,viins,vicmd up-history   '^p'
bindmodes emacs,viins,vicmd down-history '^n'

bindmodes emacs,viins backward-char '\eOD'
bindmodes emacs,viins forward-char  '\eOC'
bindmodes emacs,viins copy-prev-word '\M-;' '\e;'

# space (with or without meta) is magic-space
bindmodes emacs,viins,vicmd magic-space '\x20' '\M-\x20' '\e\x20'

# M-Q pushes all pending lines onto the stack, not just current line
bindmodes emacs,viins,vicmd push-input '\M-q' '\eq'

# Autoconvert "~?" -> "~/" since I often hold down the shift key for too long
# when trying to type the latter.
bindkey -M emacs -s '~?' '~/'
bindkey -M viins -s '~?' '~/'

# Make ^X^F force file completion
zle -C complete-file complete-word _generic
zstyle ':completion:complete-file::::' completer _files
bindkey -M emacs '^x^f' complete-file
bindkey -M viins '^x^f' complete-file

##################
# Vi bindings    #
##################
bindkey -M vicmd "/"   history-incremental-search-backward
bindkey -M vicmd "?"   history-incremental-search-forward
bindkey -M vicmd "^u"  vi-kill-line

# Avoid issue where escape in command mode will eat next character
noop () { }
zle -N noop
bindkey -M vicmd '\e' noop

bindkey -M viins '^t'  transpose-chars
bindmodes viins transpose-words  'M-t' '\et'
bindmodes viins insert-last-word 'M-.' '\e.'

# Make space with modifier another way to get into command mode
bindmodes viins vi-cmd-mode '^\x20' 'M\x20' '\e\x20'

# Start in command mode when editing history, if using Vi bindings
zle-history-line-set() { [[ `bindkey '\e'` == *vi-cmd-mode ]] && zle -K vicmd }
zle -N zle-history-line-set

###################
# Common bindings #
###################

# Automatically quote special characters in URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
