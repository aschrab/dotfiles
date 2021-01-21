setlocal formatoptions+=awn
setlocal nojoinspaces
setlocal spell
setlocal expandtab
setlocal tabstop=4

setlocal foldmethod=expr
setlocal foldexpr=fold#markdown(v:lnum)
setlocal foldlevel=1
