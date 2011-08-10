fun! PerlPackageTemplate()
  let pack = expand('%:p')
  let orig = pack

  let pack = substitute( pack, '.*/perl\(/[0-9.]\+\)\?/', '',   '' )
  let pack = substitute( pack, '.*/lib/', '',   '' )
  if pack == orig
    return
  endif

  let pack = substitute( pack, '\.pm$',   '',   '' )
  let pack = substitute( pack, '/',       '::', 'g' )

  call setline( 1, 'package ' . pack . ';' )
  call append(  1, [ '', 'use strict;', 'use warnings;', '', '', '1;' ] )
  call setpos( '.', [0, 6, 1, 1] )
endf

au BufNewFile *.pm call PerlPackageTemplate()
