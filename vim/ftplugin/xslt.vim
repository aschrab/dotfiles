setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab

if exists("b:did_ftplugin")
  finish
endif
runtime ftplugin/xml.vim
