include(`macros.m4')dnl
enable-ssh-support

extra-socket ENV(HOME)/.gnupg/S.gpg-agent.extra

ifelse(OS, {Darwin}, {dnl
pinentry-program /usr/local/bin/pinentry-mac
}, {dnl
})dnl
