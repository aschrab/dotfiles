umask 022
if [[ ,$(grep -c "^$USERNAME:x:$GID:$" /etc/group 2> /dev/null), == ",1,"
      && ",`grep -c :$GID: /etc/passwd 2> /dev/null`," == ",1," ]]
then
  umask 002
fi
