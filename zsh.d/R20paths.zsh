path=()
manpath=()
ppath=(
  ~/bin
  /usr/local/bin
  /sw/bin
  /sw/sbin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /usr/X11R6/bin
  /usr/X11/bin
  /usr/share/bin
  /usr/adm/bin
  /usr/local/pilot/bin
  /usr/ccs/bin
  /usr/ccs/lib
  /usr/games
)

for d in $ppath
do
  if [[ -d $d ]]
  then
    path=($path $d)
  fi

  m=${d%/bin}
  if [[ $d == $m ]]
    m="$m/man"
    if [[ -d $m ]]
    then
      manpath=($manpath $m)
    fi
  then
  fi
done

typeset -aU fpath
fpath=($zshrc_dir/completion $fpath)

local fdir="$zshrc_dir/functions"
fpath=($fdir $fpath)

autoload -- $fdir/*(:t)

unset ppath d m
export PATH MANPATH

path+=$(dirname $(readlink -f $zshrc_dir))/upstreams/powerline/scripts/
