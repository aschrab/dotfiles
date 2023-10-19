is-at-least 4.0 || return

# Force loading completion module so that keymaps get defined
zmodload zsh/complist

zstyle ':completion:*' rehash yes
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _show_ambiguity _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 'NUMERIC==3'
zstyle ':completion:*' format "$fg[blue]%SCompleting %d%s${fColor}"
zstyle ':completion:*' glob 'NUMERIC==1'
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' match-original both
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=** r:|=**'

zstyle ':completion::expand:::' tag-order expansions original

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Allow one error for every 3 characters typed.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*' menu select=3 auto # yes=long interactive
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 'NUMERIC==2'
zstyle :compinstall filename $HOME/.zshrc

zstyle ':completion:*:ssh:*' tag-order '!users'
zstyle ':completion:*:scp:*' tag-order '!users'

# For the `token` command, complete options without requiring the `-` to be typed.
zstyle ':completion:*:token:*' tag-order options

# Don't complete "CVS" or "lost+found" directories
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS' '(*/)#lost+found' \
  '(|*/)*.bak' '(|*/)*.swp' '(|*/)*.o' '(|*/)*.pyc' '(|*/)*~'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS' '(*/)#lost+found'
zstyle ':completion:*:rm:*' ignored-patterns
zstyle ':completion:*' file-sort modification
# When completing small numbers of files, use format similar to `ls -l`
zstyle ':completion:*' file-list list=20 insert=10

# Ignore some commands when doing completion
() {
  local ignore=(
    '_*' # completion functions
    'vcs_info*' # VCS info functions
    '*-linux-gnu-*' # architecture-specific build tools
    'lam' # laminate command, similar to paste(1)
  )

  zstyle ':completion:*:-command-:*' ignored-patterns "${ignore[@]}"
}

# Also, don't suggest completion functions as alternative if entered command wasn't found
export CORRECT_IGNORE='_*'

if [[ $USER == 'root' ]]; then
  # Display all processes
  zstyle ':completion:*:*:*:*:processes' 'command' 'ps ax'
else # Display all of current user's processes.
  zstyle ':completion:*:*:*:*:processes' 'command' 'ps x'
fi

# Display list of processes even if there's only one match
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always

# Color process list in ps completion
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

zstyle ':completion:*:*:git:*' user-commands \
  reintegrate:'Rebuild integration branch' \
  rmerge:'Merge into other branch' \
  pr-update:'Update local checkout of a PR' \
  default:'Switch to default branch' \

# Include the fake `ARGV0` when completing parameters
zstyle ':completion::*:(-command-|export):*' fake-parameters ARGV0=
