" Copied from https://github.com/tpope/vim-fugitive/pull/814#issuecomment-446767081

function! s:Resolve()
  let current = expand('%')
  let resolved = resolve(current)
  if current !=# resolved
    silent execute 'keepalt file' fnameescape(resolved)
    return 'edit'
  endif
  return ''
endfunction

command -bar Resolve execute s:Resolve()

augroup resolve
  autocmd!
  autocmd BufReadPost * nested
        \ if exists('*FugitiveExtractGitDir') && !exists('b:git_dir') &&
        \     expand('%') !=# resolve(expand('%')) &&
        \     len(FugitiveExtractGitDir(resolve(expand('%')))) |
        \   Resolve |
        \ endif
augroup END
