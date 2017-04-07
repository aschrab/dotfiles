# Copied from https://github.com/Vifon/zsh-config/blob/1a7d1502daf9da3d9aa91bc54e91e29de3111e5f/zplugins/zle-config#L183

__create_generic_completion()
{
    autoload -U split-shell-arguments
    local reply REPLY REPLY2

    split-shell-arguments

    local i
    for ((i = $#reply-1; i > 0; --i)); do
        case $reply[i] in
            ';'|'|'|'||'|'&'|'&&'|'sudo')
                break
                ;;
        esac
    done

    compdef _gnu_generic $reply[i+2]
}
zle -N __create_generic_completion
bindmodes emacs,viins,vicmd __create_generic_completion '^X^G'
