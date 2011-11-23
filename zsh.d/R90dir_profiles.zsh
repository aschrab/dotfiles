zstyle ':chpwd:profiles:/home/ats/vc/dotfiles(|/|/*)' profile dotfiles
zstyle ':chpwd:profiles:/home/ats/vc/blackjack(|/|/*)' profile blackjack

function chpwd_profile_default {
}

function chpwd_profile_dotfiles {
  PROJECT=dotfiles
}

function chpwd_profile_blackjack {
  PROJECT=blackjack
}
