setlocal foldtext=pug#foldText()
setlocal spell

" Hack to avoid redoing indent of line being finished when return key is hit.
aug qqx
au CursorHold <buffer> setlocal indentkeys-=*<Return> | aug qqx | au! * <buffer>
