# Try making directory, don't care if it fails (may be there already)
mkdir "/tmp/$LOGNAME" >& /dev/null

# On some systems $LOGNAME stays the same across su, so check if TMPDIR for
# non-root user was created by root, and fix it if necessary
if [[ $EUID -eq 0 && "$LOGNAME" != root && -n "`echo /tm[p]/$LOGNAME(Nu0)`" ]]
then
  echo "TMPDIR owned by root, fixing" >&2
  chown "$LOGNAME" "/tmp/$LOGNAME"
fi

# Check the ownership, and make sure the permisisons are correct
if [[ `echo /tmp/$LOGNAME(Nu:$LOGNAME:)` == /tmp/$LOGNAME(/|) ]] &&
   chmod 0700 "/tmp/$LOGNAME" >& /dev/null
then
  export TMPDIR="/tmp/$LOGNAME"
  export TMP="$TMPDIR"
  export TMPPREFIX="$TMPDIR/zsh"
else
  echo "TMPDIR not secure" >&2
  echo "TMPDIR not secure" >&2
  echo "TMPDIR not secure" >&2
fi
