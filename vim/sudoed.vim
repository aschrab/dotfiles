let myvimdir=expand("<sfile>:h")
let &runtimepath = myvimdir . ',' . &runtimepath . ',' . myvimdir . '/after'
runtime vimrc
