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
  /usr/local/pkg/guru
  /usr/local/pkg/dnvs
  /usr/local/adm/voyager
  /usr/local/adm/execpc
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

unset ppath d m
export PATH MANPATH
