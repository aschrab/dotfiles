bindkey -v

##################
# Emacs bindings #
##################
bindkey -M emacs \^p up-history
bindkey -M emacs \^n down-history
bindkey -M emacs "\e[A" up-line-or-search
bindkey -M emacs "\eOA" up-line-or-search
bindkey -M emacs "\eOD" backward-char
bindkey -M emacs "\eOC" forward-char
bindkey -M emacs "\e[5D" backward-word  # ctrl + left-arrow
bindkey -M emacs "\e[5C" forward-word   # ctrl + right-arrow
bindkey -M emacs "\e[1;5D" backward-word  # ctrl + left-arrow
bindkey -M emacs "\e[1;5C" forward-word   # ctrl + right-arrow
bindkey -M emacs "\M-;" copy-prev-word
bindkey -M emacs "\e;" copy-prev-word

# space (with or without meta) is magic-space
bindkey -M emacs    "\x20" magic-space
bindkey -M emacs "\M-\x20" magic-space
bindkey -M emacs  "\e\x20" magic-space

# M-Q pushes all pending lines onto the stack, not just current line
bindkey -M emacs "\M-q" push-input
bindkey -M emacs "\eq" push-input

# Autoconvert "~?" -> "~/" since I often hold down the shift key for too long
# when trying to type the latter.
bindkey -M emacs -s '~?' '~/'

# Make ^X^F force file completion
zle -C complete-file complete-word _generic
zstyle ':completion:complete-file::::' completer _files
bindkey -M emacs '^x^f' complete-file

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

bindkey -M viins "^a"  beginning-of-line
bindkey -M viins "^e"  end-of-line
bindkey -M viins "^k"  kill-line
bindkey -M viins "^t"  transpose-chars
bindkey -M viins "M-t" transpose-words
bindkey -M viins "\et" transpose-words
bindkey -M viins "M-;" copy-prev-word
bindkey -M viins "\e;" copy-prev-word
bindkey -M viins "M-." insert-last-word
bindkey -M viins "\e." insert-last-word

# Make control+space another way to get into command mode
bindkey -M viins '^\x20' vi-cmd-mode

# space (with or without meta) is magic-space
bindkey -M viins    "\x20" magic-space
bindkey -M viins "\M-\x20" magic-space
bindkey -M viins  "\e\x20" magic-space

# Start in command mode when editing history, if using Vi bindings
zle-history-line-set() { [[ `bindkey '\e'` == *vi-cmd-mode ]] && zle -K vicmd }
zle -N zle-history-line-set

###################
# Common bindings #
###################

# Automatically quote special characters in URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
