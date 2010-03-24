# Set $host by:
# - Split $HOST on '.'
# - Remove $stripdom - 1 portions from the end
# - Rejoin
if [[ "$HOST" = *.local ]]
then
  host=${HOST/.*/}
elif [[ "$HOST" = *.* ]]
then
  stripdom=3
  host=${(j:.:)${(s:.:)HOST}[1,-$stripdom]}
  if [[ -z "$host" ]]
  then
    host="$HOST"
  fi
else
  host="$HOST"
fi
export host
