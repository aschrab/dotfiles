# vim: ft=zsh

[[ $ZSH_MAJOR_VERSION -lt 4 ]] && return

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 'NUMERIC==3'
zstyle ':completion:*' format "${blue}%SCompleting %d%s${fColor}"
zstyle ':completion:*' glob 'NUMERIC==1'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' match-original both
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=** r:|=**'

# Allow one error for every 3 characters typed.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*' menu select=10
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 'NUMERIC==2'
zstyle ':completion:*' ignored-patterns 'doc-base'
zstyle :compinstall filename $HOME/zcomp

zstyle ':completion:*:ssh:*' users 'reply=()'
zstyle ':completion:*:scp:*' users 'reply=()'

# Don't complete "CVS" or "lost+found" directories
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS' '(*/)#lost+found' \
  '(|*/)*.bak' '(|*/)*.swp' '(|*/)*.o' '(|*/)*~'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS' '(*/)#lost+found'
zstyle ':completion:*:rm:*' ignored-patterns


# Try to avoid completion functions when completing command names.
zstyle ':completion:*:commands' ignored-patterns '_*'

if [[ $USER == 'root' ]]; then
  # Display all processes
  zstyle ':completion:*:*:*:*:processes' 'command' 'ps ax'
else # Display all of current user's processes.
  zstyle ':completion:*:*:*:*:processes' 'command' 'ps -u$USER'
fi

# Display list of processes even if there's only one match
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always

# Color process list in ps completion
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
