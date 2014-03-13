function! perl#package_name()
  let pack = expand('%:p')
  let orig = pack

  try
    let pack = fugitive#buffer().path()
  catch
  endtry

  let pack = substitute( pack, '\(.*/\|\)perl\(/[0-9.]\+\)\?/', '',   '' )
  let pack = substitute( pack, '\(.*/\|\)lib/', '',   '' )

  if pack == orig
    return ''
  endif

  let pack = substitute( pack, '\.pm$',   '',   '' )
  let pack = substitute( pack, '/',       '::', 'g' )

  return pack
endfunction

function! perl#module_file_name(n)
  return substitute( a:n, '::', '/', 'g' ) . '.pm'
endfunction

function! perl#get_lib_paths()
  let out = system('perl -e ''print join "\n", @INC''')
  let paths = split( out, "\n" )
  return paths
endfunction

function! perl#find_perl_module_file(module)
  let paths = [ 'lib' ] + perl#get_lib_paths()
  let fname = perl#module_file_name( a:module )

  for p in paths
    let f = p . '/' . fname
    if filereadable(f)
      return f
    endif
  endfor

  echo "Module not found: " . a:module
endfunction

function! perl#open_module_name(module)
  if filereadable(a:module)
    exe ":1,$!cat " . a:module
    return
  endif

  let fname = perl#find_perl_module_file(a:module)
  if !empty(fname)
    echo "Reading " . fname
    exe ":1,$!cat " . fname
    setlocal readonly buftype=nofile ft=perl
  endif
endfunction
