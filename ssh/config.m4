include(`macros.m4')dnl
define({atleast}, {ifelse(sh({perl -E '$_ = `ssh -V 2>&1`; chomp; s/^OpenSSH_//; s/p.*//; say version->parse($_) > v$1 ? "New" : "Old"'}), {New}, $2, $3)})dnl
IgnoreUnknown AddKeysToAgent{,}UseKeychain
AddKeysToAgent yes
UseKeychain yes
# VisualHostKey yes

ifelse(OS, {Darwin}, {
XAuthLocation /opt/X11/bin/xauth
define({XForward}, {})dnl
}, {
define({XForward}, {dnl
ForwardX11 yes
ForwardX11Trusted yes
})dnl
})dnl

HashKnownHosts no
ControlMaster auto
ControlPath ~/.ssh/.master.%C
ControlPersist 30
#VerifyHostKeyDNS=ask
ServerAliveInterval=5

Host pug.qqx.org proxy
#Port 443

Host proxy
HostName pug.qqx.org
HostKeyAlias pug.qqx.org
DynamicForward 9876

Host gay-deceiver.qqx.org

Host zim.qqx.org
#ProxyCommand ssh home.qqx.org nc zim.dyn.qqx.org %p

Host kahlan*
ForwardX11 no
Port 22

Host moya.trilug.org
Port 622

Host dargo.trilug.org
User ats
ForwardAgent yes
ForwardX11 yes

Host zhaan.trilug.org
ForwardAgent yes
ForwardX11 yes

Host pilot.trilug.org
Port 443
AddressFamily inet

Host pilotvm pilotvm.trilug.org
#HostName moya.trilug.org
HostKeyAlias pilot.trilug.org
CheckHostIP no
User aschrab

Host *.qqx.org *.lan *.local proxy 172.17.*
User ats
ForwardAgent yes
XForward
#ForwardX11Timeout 3w
Port 222

Host *.trilug.org
User aschrab
ForwardAgent no

Host lish
User qqx
HostName lish-atlanta.linode.com

Host *.rsync.net
BatchMode yes
PasswordAuthentication no
PreferredAuthentications publickey

Host *.github.com github.com
  CheckHostIP no

Host vagrant
  HostName 127.0.0.1
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  ForwardAgent yes
# User vagrant
# PasswordAuthentication no
# IdentityFile /home/ats/.vagrant.d/insecure_private_key
# IdentitiesOnly yes
  LogLevel FATAL

Host *
  PubkeyAcceptedAlgorithms sk-ssh-ed25519@openssh.com,ecdsa-sha2-nistp256,ecdsa-sha2-nistp256-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-256
  ServerAliveCountMax 2

# vim: ft=sshconfig
