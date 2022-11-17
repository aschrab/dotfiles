include(`macros.m4')dnl
define({atleast}, {ifelse(sh({perl -E '$_ = `ssh -V 2>&1`; chomp; s/^OpenSSH_//; s/p.*//; say version->parse($_) > v$1 ? "New" : "Old"'}), {New}, $2, $3)})dnl
define({RUNDIR}, ifelse(OS, {Darwin}, {ENV(HOME)/.}, {/run/user/1000/}))dnl
atleast({6.3}, {dnl
IgnoreUnknown AddKeysToAgent
AddKeysToAgent yes
})dnl
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
ControlPath ~/.ssh/.master.atleast({6.7}, {%C}, {%r@%h:%p})
ControlPersist 30
#VerifyHostKeyDNS=ask
ServerAliveInterval=5

Host niq.qqx.org ng.qqx.org
Port 22
User aschrab
LocalForward localhost:27017 0:27017
# LocalForward localhost:4200 0:4200
# LocalForward localhost:5000 0:5000
# LocalForward localhost:9229 0:9229

Host aschrab-mbp.lan
User aschrab
Port 22
ForwardAgent yes

Host pug.qqx.org proxy
#Port 443

Host proxy
HostName pug.qqx.org
HostKeyAlias pug.qqx.org
DynamicForward 9876

Host proxy pug.qqx.org
atleast({6.7}, {RemoteForward /run/user/1000/gnupg/S.gpg-agent RUNDIR{}gnupg/S.gpg-agent.extra})

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

Host ngage.netapp.com atla-app*.netapp.com
ForwardX11 no
ForwardAgent no

Host *.netapp.com
XForward

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

# EC2 nodes
Host 172.30.*
  User ubuntu
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  ChallengeResponseAuthentication no
  KbdInteractiveAuthentication no

# New IT EC2 nodes
Host 10.105.132.*
  User ubuntu
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  ChallengeResponseAuthentication no
  KbdInteractiveAuthentication no

# IT EC2 nodes
Host 10.105.*
  User root
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  ChallengeResponseAuthentication no
  KbdInteractiveAuthentication no

Host meilisearch-dev
  HostName 10.105.88.51
  User admin
  IdentityAgent none
  IdentitiesOnly yes
  IdentityFile ~/.ssh/meilisearch.pem
  ForwardAgent no
  AddKeysToAgent no

Host *
  PubkeyAcceptedAlgorithms ecdsa-sha2-nistp256,ecdsa-sha2-nistp256-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-256
  ServerAliveCountMax 2

# vim: ft=sshconfig
