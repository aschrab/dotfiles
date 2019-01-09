# vim: ft=zsh
#
if [[ -r ~/.gnupg/gpg-agent.conf ]] ; then
  gpg-agent &>/dev/null ||
    gpg-agent --homedir ~/.gnupg --daemon --sh >| ~/.gnupg/env
fi

[[ -r ~/.gnupg/env ]] && source ~/.gnupg/env
