function __chroot () {
  read -cA args
  
  reply=($(cd "$args[2]";
           find . -perm +0111 -print 2> /dev/null | sed 's:^./:/:' ))
}

compctl -x \
    'p[1]' -g '*(/)' - \
    'p[2]' -K __chroot - \
    'p[2,99]' -l '' -- \
  chroot

compctl -x \
    'p[1]' -g '*(/)' - \
    'p[2]' -u - \
    'p[3]' -K __chroot - \
    'p[3,99]' -l '' -- \
  chrootuid
