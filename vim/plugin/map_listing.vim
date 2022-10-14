" https://stackoverflow.com/a/38735360/1507392

function! s:MapListing()
  let old_reg = getreg("a")          " save the current content of register a
  let old_reg_type = getregtype("a") " save the type of the register as well
  try
    redir @a                           " redirect output to register a
    " Get the list of all key mappings silently, satisfy "Press ENTER to continue"
    silent map | call feedkeys("\<CR>")
    redir END                          " end output redirection
    vnew                               " new buffer in vertical window
    setlocal buftype=nofile            " don't complain about it not getting saved
    put a                              " put content of register
    " Sort on 4th character column which is the key(s)
    %!sort -k1.4,1.4
  finally                              " Execute even if exception is raised
    call setreg("a", old_reg, old_reg_type) " restore register a
  endtry
endfunction

com! MapListing call s:MapListing()      " Enable :ShowMaps to call the function
