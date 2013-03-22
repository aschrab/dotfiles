typeset -aU fpath
fpath=($zshrc_dir/completion $fpath)

local fdir="$zshrc_dir/functions"
fpath=($fdir $fpath)

autoload -- $fdir/*(:t)

path+=$(dirname $(readlink -f $zshrc_dir))/upstreams/powerline/scripts/
