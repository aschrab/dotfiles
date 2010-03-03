# vim: ft=zsh

tz () {
  local t
  t="$1"
  shift
  TZ="$t" "$@"
}

compctl -x \
   'p[1,1] C[0,*/*]' -g '/usr/share/zoneinfo/**/*(:s,/usr/share/zoneinfo/,,)' \
   - 'p[1,1]' -g '/usr/share/zoneinfo/*(:t)' \
   - 'p[2,99]' -l '' \
 -- tz
