bindkey -e

# bind keys
bindkey \^p up-history
bindkey \^n down-history
bindkey "\e[A" up-line-or-search
bindkey "\eOA" up-line-or-search
bindkey "\eOD" backward-char
bindkey "\eOC" forward-char
bindkey "\e[5D" backward-word  # ctrl + left-arrow
bindkey "\e[5C" forward-word   # ctrl + right-arrow
bindkey "\M-;" copy-prev-word
bindkey "\e;" copy-prev-word
# space (with or without meta) is magic-space
bindkey    "\x20" magic-space
bindkey "\M-\x20" magic-space
bindkey "\e\x20" magic-space
# M-Q pushes all pending lines onto the stack, not just current line
bindkey "\M-q" push-input
bindkey "\eq" push-input
# Autoconvert "~?" -> "~/" since I often hold down the shift key for too long
# when trying to type the latter.
bindkey -s '~?' '~/'
