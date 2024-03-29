# vim: ft=zsh

if (( $+commands[gpg-agent] )) && [[ -r ~/.gnupg/gpg-agent.conf ]] ; then
  [[ -r ~/.gnupg/env ]] && [[ ! -s ~/.gnupg/env ]] && killall -9 gpg-agent 2>/dev/null
  gpg-agent &>/dev/null ||
    gpg-agent --homedir ~/.gnupg --daemon --sh >| ~/.gnupg/env
fi

[[ -r ~/.gnupg/env ]] && source ~/.gnupg/env

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_UPDATE_REPORT_ONLY_INSTALLED=1
export HOMEBREW_EVAL_ALL=y

if [[ -z "$SSH_AUTH_SOCK" ]] && [[ -e "/run/user/$UID/gnupg/S.gpg-agent.ssh" ]]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi
