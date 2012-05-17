fun! PerlPackageTemplate()
  let pack = PerlPackageName()

  call setline( 1, 'package ' . pack . ';' )
  call append(  1, [ '', 'use strict;', 'use warnings;', '', '', '1;' ] )
  call setpos( '.', [0, 6, 1, 1] )
  call feedkeys( 'zx' )
endf

au BufNewFile *.pm call PerlPackageTemplate()
