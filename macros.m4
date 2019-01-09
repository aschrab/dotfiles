changequote({,})dnl
define({strip}, {substr($1, 0, decr(len($1)))})dnl
define({sh}, {strip(esyscmd($1))})dnl
define({ENV}, {sh({echo "$$1"})})dnl
define({OS}, sh(uname))dnl
