typeset -aU fpath
fpath=($zshrc_dir/completion $fpath)

local fdir="$zshrc_dir/functions"
fpath=($fdir $fpath)

autoload -- $fdir/*(:t)

path+=$(dirname $(perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' $zshrc_dir))/upstreams/powerline/scripts/
