bindkey -v

bindmodes emacs,viins complete-word $'\t'

bindmodes emacs,viins,vicmd up-line-or-search '\e[A' '\eOA' # Up arrow
bindmodes emacs,viins,vicmd backward-word '\e[5D' '\e[1;5D' # ctrl + left-arrow
bindmodes emacs,viins,vicmd forward-word  '\e[5C' '\e[1;5C' # ctrl + right-arrow

bindmodes emacs,viins,vicmd up-history   '^p'
bindmodes emacs,viins,vicmd down-history '^n'

bindmodes emacs,viins backward-char '\eOD'
bindmodes emacs,viins forward-char  '\eOC'
bindmodes emacs,viins copy-prev-shell-word '\M-;' '\e;'

bindmodes emacs,viins,vicmd run-help '\M-h' '\eh'

# Delete key
bindmodes emacs,viins,vicmd delete-char '\e[3~'

# space (with or without meta) is magic-space
bindmodes emacs,viins,vicmd magic-space '\x20' '\M-\x20' '\e\x20'

# M-Q pushes all pending lines onto the stack, not just current line
bindmodes emacs,viins,vicmd push-input '\M-q' '\eq'

# Apply quotes to the current line/region
bindmodes emacs,viins,vicmd quote-line '\M-'\' '\e'\'
bindmodes emacs,viins,vicmd quote-region '\M-"' '\e"'

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
bindkey -M vicmd "?"   history-incremental-pattern-search-backward
bindkey -M vicmd "/"   history-incremental-pattern-search-forward
bindkey -M vicmd "^u"  vi-kill-line

bindkey -M vicmd '""'  quote-line

# Avoid issue where escape in command mode will eat next character
bindkey -M vicmd -s '\e' ''

() {
  local n
  for n in {0..9}
  do
    bindmodes viins,vicmd digit-argument "\M-$n" "\\e$n"
  done
}

bindkey -M viins '^t'  transpose-chars
bindmodes viins transpose-words  'M-t' '\et'
bindmodes viins insert-last-word 'M-.' '\e.'

# Make space with modifier another way to get into command mode
bindmodes viins vi-cmd-mode '^\x20' 'M\x20' '\e\x20'

# Allow "jl" to escape to command mode
bindmodes viins vi-cmd-mode 'jl'

# Use shift+tab to expand glob in place
bindkey -M viins '\e[Z' expand-word

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# autoload -Uz insert-files
# zle -N insert-files
# bindkey -M viins '^F' insert-files

###################
# Common bindings #
###################

# Automatically quote special characters in URLs
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic && zle -N bracketed-paste bracketed-paste-magic && \
  zstyle :bracketed-paste-magic paste-init backward-extend-paste

if is-at-least 5.2; then
  autoload -U select-quoted
  zle -N select-quoted
  for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
      bindkey -M $m $c select-quoted
    done
  done

  autoload -U select-bracketed
  zle -N select-bracketed
  for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
      bindkey -M $m $c select-bracketed
    done
  done

  autoload -Uz surround
  zle -N delete-surround surround
  zle -N add-surround surround
  zle -N change-surround surround
  bindkey -a cs change-surround
  bindkey -a ds delete-surround
  bindkey -a ys add-surround
  bindkey -M visual S add-surround
fi

# Within menu select, char motions actually move by columns (matches)
bindkey -M menuselect .     forward-char
bindkey -M menuselect ,     backward-char
# Within menu select word motions actually move by groups
bindkey -M menuselect '<'   forward-word
bindkey -M menuselect '>'   backward-word
# Allow tab to be used to begin another completion (e.g. files within a directory)
bindkey -M menuselect '^i'  accept-and-infer-next-history
# Allow use of + to insert current selection and continue to selecting others
bindkey -M menuselect '+'   accept-and-hold
bindkey -M menuselect '\e'  undo
bindkey -M menuselect '^f'  history-incremental-search-forward

# Change enter in incremental search to only select an entry, not execute it.
bindkey -M isearch '^M' accept-search

# Shortcut for inserting current path relative to $HOME.  Main anticipated use
# is when I want to refer to same directory on a different system with scp.
_ins_current_path() {
  LBUFFER+=$(print -n -P '%~')
}
zle -N _ins_current_path
bindkey -M viins '\e`' _ins_current_path
