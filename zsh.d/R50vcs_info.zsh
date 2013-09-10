autoload -Uz vcs_info
precmd_functions+='vcs_info'

zstyle ':vcs_info:*' enable git p4
zstyle ':vcs_info:*' stagedstr '✓'
zstyle ':vcs_info:*' unstagedstr '△'
#zstyle ':vcs_info:*' use-quilt true

zstyle ':vcs_info:git:*' check-for-changes true
# If the VCS is git, don't mention that it'll be assumed
zstyle ':vcs_info:git:*' formats "[%b]%c%u" '%R'
zstyle ':vcs_info:git:*' actionformats "[%b|%a]%c%u"

export P4HUSH=1
P4CONFIG=P4ENV
