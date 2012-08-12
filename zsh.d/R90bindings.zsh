bindkey -e

# bind keys
bindkey -M emacs \^p up-history
bindkey -M emacs \^n down-history
bindkey -M emacs "\e[A" up-line-or-search
bindkey -M emacs "\eOA" up-line-or-search
bindkey -M emacs "\eOD" backward-char
bindkey -M emacs "\eOC" forward-char
bindkey -M emacs "\e[5D" backward-word  # ctrl + left-arrow
bindkey -M emacs "\e[5C" forward-word   # ctrl + right-arrow
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

# Automatically quote special characters in URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
