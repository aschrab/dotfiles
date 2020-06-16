# vim: ft=zsh
#
if [[ -r ~/.gnupg/gpg-agent.conf ]] ; then
  [[ -r ~/.gnupg/env ]] && [[ ! -s ~/.gnupg/env ]] && killall -9 gpg-agent
  gpg-agent &>/dev/null ||
    gpg-agent --homedir ~/.gnupg --daemon --sh >| ~/.gnupg/env
fi

[[ -r ~/.gnupg/env ]] && source ~/.gnupg/env

export HOMEBREW_NO_AUTO_UPDATE=1
