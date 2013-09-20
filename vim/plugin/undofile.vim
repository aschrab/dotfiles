:if has("persistent_undo")
au BufWritePre /tmp/* setlocal noundofile
au BufWritePre COMMIT_EDITMSG setlocal noundofile
:endif
