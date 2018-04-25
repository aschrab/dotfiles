function airline#ext#branch_format(name)
  let name = a:name
  let name = substitute(name, '.\zs[^/]*/', '/', 'g')
  let name = substitute(name, '/\zs[A-Z]\+[-_]\ze[0-9]\+[-_]', '', '')
  return name
endf
