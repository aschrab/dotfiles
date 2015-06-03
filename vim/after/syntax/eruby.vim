unlet b:current_syntax
syntax include @JS syntax/javascript.vim
syntax region jsonSnip matchgroup=Snip start=+//-- JS+ end=+//-- ENDJS+ contains=@JS

let b:current_syntax = "eruby"
