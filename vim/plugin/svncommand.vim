" vim600: set foldmethod=marker ts=2 sts=2:
" $Id: svncommand.vim 879 2004-02-26 04:46:28Z laz $
"
" Vim plugin to assist in working with SVN-controlled files.
"
" Last Change:   $Date: 2004-02-25 23:46:28 -0500 (Wed, 25 Feb 2004) $
" Maintainer:    Adam Lazur <adam@lazur.org>
" License:       This file is placed in the public domain.
" Version:       2
"
" Section: Documentation {{{1
"
" This is mostly a s/CVS/SVN/g on cvscommand.vim by Bob Hiestand
" <bob@hiestandfamily.org> with some svn translations for various things.
"
" Provides functions to invoke various SVN commands on the current file.
" The output of the commands is captured in a new scratch window.  For
" convenience, if the functions are invoked on a SVN output window, the
" original file is used for the svn operation instead after the window is
" split.  This is primarily useful when running SVNCommit and you need to see
" the changes made, so that SVNDiff is usable and shows up in another window.
"
" These functions are exported into the global environment, meaning they are
" directly accessed without prepending '<PLUG>'.  This is because the author
" directly accesses several of them without using the mappings in order to
" pass parameters.
"
" Several of these act immediately, such as
"
" SVNAdd        Performs "svn add" on the current file.
"
" SVNAnnotate   Performs "svn annotate" on the current file.  If not given an
"               argument, uses the most recent version of the file.
"               Otherwise, the argument is used as a revision number.
"
" SVNCommit     This is a two-stage command.  The first step opens a buffer to
"               accept a log message.  When that buffer is written, it is
"               automatically closed and the file is committed using the
"               information from that log message.  If the file should not be
"               committed, just destroy the log message buffer without writing
"               it.
"
" SVNDiff       With no arguments, this performs "svn diff" on the current
"               file.  With one argument, "svn diff" is performed on the
"               current file against the specified revision.  With two
"               arguments, svn diff is performed between the specified
"               revisions of the current file.  This command uses the
"               'SVNCommandDiffOpt' variable to specify diff options.  If that
"               variable does not exist, then 'wbBc' is assumed.  If you wish
"               to have no options, then set it to the empty string.
"
" SVNLog        Performs "svn log" on the current file.
"
" SVNReview     Retrieves a particular version of the current file.  If no
"               argument is given, the most recent version of the file on
"               the current branch is retrieved.  The specified revision is
"               retrieved into a new buffer.
"
" SVNStatus     Performs "svn status" on the current file.
"
" SVNInfo       Performs "svn info" on the current file.
"
" SVNUpdate     Performs "svn update" on the current file.
"
" SVNVimDiff    With no arguments, this prompts the user for a revision and
"               then uses vimdiff to display the differences between the current
"               file and the specified revision.  If no revision is specified,
"               the most recent version of the file on the current branch is used.
"               With one argument, that argument is used as the revision as
"               above.  With two arguments, the differences between the two
"               revisions is displayed using vimdiff.
"
"               With either zero or one argument, the original buffer is used
"               to perform the vimdiff.  When the other buffer is closed, the
"               original buffer will be returned to normal mode.
"
" By default, a mapping is defined for each command.  User-provided mappings
" can be used instead by mapping to <Plug>CommandName, for instance:
"
" nnoremap ,ca <Plug>SVNAdd
"
" The default mappings are as follow:
"
"   <Leader>sa SVNAdd
"   <Leader>sn SVNAnnotate
"   <Leader>sc SVNCommit
"   <Leader>sd SVNDiff
"   <Leader>sl SVNLog
"   <Leader>sr SVNReview
"   <Leader>ss SVNStatus
"   <Leader>si SVNInfo
"   <Leader>sq SVNRevert
"   <Leader>sv SVNVimDiff
"
" Options:
"
" Several variables are checked by the script to determine behavior as follow:
"
" SVNCommandDeleteOnHide
"   This variable, if set to a non-zero value, causes the temporary SVN result
"   buffers to automatically delete themselves when hidden.
"
" SVNCommandDiffOpt
"   This variable, if set, determines the options passed to the "svn diff"
"   command.  If not set, it defaults to ''.
"
" SVNCommandNameMarker
"   This variable, if set, configures the special attention-getting characters
"   that appear on either side of the svn buffer type in the buffer name.  If
"   not set, it defaults to '_'.
"
" SVNCommandSplit
"   This variable controls the orientation of the buffer split when executing
"   the SVNVimDiff command.  If set to 'horizontal', the resulting buffers
"   will be on top of one another.

" Section: Plugin header {{{1

if exists("loaded_svncommand")
   finish
endif
let loaded_svncommand = 1

" Section: Utility functions {{{1

" Function: s:SVNResolveLink() {{{2
" Fully resolve the given file name to remove shortcuts or symbolic links.

function! s:SVNResolveLink(fileName)
  let resolved = resolve(a:fileName)
  if resolved != a:fileName
    let resolved = s:SVNResolveLink(resolved)
  endif
  return resolved
endfunction

" Function: s:SVNChangeToCurrentFileDir() {{{2
" Go to the directory in which the current SVN-controlled file is located.
" If this is a SVN command buffer, first switch to the original file.

function! s:SVNChangeToCurrentFileDir()
  let oldCwd=getcwd()
  let fileName=s:SVNResolveLink(@%)
  let newCwd=fnamemodify(fileName, ':h')
  if strlen(newCwd) > 0
    execute 'cd' escape(newCwd, ' ')
  endif
  return oldCwd
endfunction

" Function: s:SVNCreateCommandBuffer(cmd, cmdname, filename) {{{2
" Creates a new scratch buffer and captures the output from execution of the
" given command.  The name of the scratch buffer is returned.

function! s:SVNCreateCommandBuffer(cmd, cmdname, filename)
  let nameMarker = s:SVNGetOption("SVNCommandNameMarker", '_')
  let origBuffNR=bufnr("%")
  let bufName=a:filename . ' ' . nameMarker . a:cmdname . nameMarker
  let counter=0
  let currentBufName = bufName
  while buflisted(currentBufName)
    let counter=counter + 1
    let currentBufName=bufName . ' (' . counter . ')'
  endwhile
  let currentBufName = escape(currentBufName, ' *\')

  if s:SVNEditFile(currentBufName) == -1
    return ""
  endif

  set buftype=nofile
  set noswapfile
  set filetype=
  if s:SVNGetOption("SVNCommandDeleteOnHide", 0)
    set bufhidden=delete
  else
    set bufhidden=hide
  endif
  let b:svnOrigBuffNR=origBuffNR
  silent execute a:cmd
  $d
  1
  return currentBufName
endfunction

" Function: s:SVNBufferCheck() {{{2
" Attempts to locate the original file to which SVN operations were applied.

function! s:SVNBufferCheck()
  if exists("b:svnOrigBuffNR")
    if bufexists(b:svnOrigBuffNR)
      execute "sbuffer" . b:svnOrigBuffNR
      return 1
    else
      " Original buffer no longer exists.
      return -1
    endif
  else
    " No original buffer
    return 0
  endif
endfunction

" Function: s:SVNToggleDeleteOnHide() {{{2
" Toggles on and off the delete-on-hide behavior of SVN buffers

function! s:SVNToggleDeleteOnHide()
  if exists("g:SVNCommandDeleteOnHide")
    unlet g:SVNCommandDeleteOnHide
  else
    let g:SVNCommandDeleteOnHide=1
  endif
endfunction

" Function: s:SVNGetOption(name, default) {{{2
" Grab a user-specified option to override the default provided.  Options are
" searched in the window, buffer, then global spaces.

function! s:SVNGetOption(name, default)
  if exists("w:" . a:name)
    execute "return w:".a:name
  elseif exists("b:" . a:name)
    execute "return b:".a:name
  elseif exists("g:" . a:name)
    execute "return g:".a:name
  else
    return a:default
  endif
endfunction

" Function: s:SVNEditFile(name) {{{2
" Wrapper around the 'edit' command to provide some helpful error text if the
" current buffer can't be abandoned.
" Returns: 0 if successful, -1 if an error occurs.

function! s:SVNEditFile(name)
  let v:errmsg = ""
  execute 'edit' a:name
  if v:errmsg != ""
    if &modified && !&hidden
      echoerr "Unable to open command buffer because 'nohidden' is set and the current buffer is modified (see :help 'hidden')."
    else
      echoerr "Unable to open command buffer" v:errmsg
    endif
    return -1
  endif
endfunction

" Function: s:SVNDoCommand(svncmd, cmdName) {{{2
" General skeleton for SVN function execution.
" Returns: name of the new command buffer containing the command results

function! s:SVNDoCommand(cmd, cmdName)
  let svnBufferCheck=s:SVNBufferCheck()
  if svnBufferCheck == -1 
    echo "Original buffer no longer exists, aborting."
    return ""
  endif

  let fileName=@%
  let realFileName = fnamemodify(s:SVNResolveLink(fileName), ':t')
  let oldCwd=s:SVNChangeToCurrentFileDir()
  let fullCmd = '0r!' . a:cmd . ' "' . realFileName . '"'
  let resultBufferName=s:SVNCreateCommandBuffer(fullCmd, a:cmdName, fileName)
  execute 'cd' escape(oldCwd, ' ')
  return resultBufferName
endfunction

" Section: SVN functions {{{1

" Function: s:SVNAdd() {{{2
function! s:SVNAdd()
  return s:SVNDoCommand('svn add', 'svnadd')
endfunction

" Function: s:SVNAnnotate(...) {{{2
function! s:SVNAnnotate(...)
  let svnBufferCheck=s:SVNBufferCheck()
  if svnBufferCheck == -1 
    echo "Original buffer no longer exists, aborting."
    return ""
  endif

  let currentLine=line(".")
  let oldCwd=s:SVNChangeToCurrentFileDir()

  if a:0 == 0
    let revOptions = ''
    let caption = 'current'
  else
    let revOptions = '-r' . a:1
    let caption = 'r' . a:1
  endif

  let resultBufferName=s:SVNCreateCommandBuffer('0r!svn annotate ' . revOptions . ' "' . s:SVNResolveLink(@%) . '"', 'svnannotate', expand("%"))
  if resultBufferName != "" 
    exec currentLine
    set filetype=SVNAnnotate
  endif

  execute 'cd' escape(oldCwd, ' ')
  return resultBufferName
endfunction

" Function: s:SVNCommit() {{{2
function! s:SVNCommit()
  let svnBufferCheck=s:SVNBufferCheck()
  if svnBufferCheck ==  -1
    echo "Original buffer no longer exists, aborting."
    return ""
  endif

  let originalBuffer=bufnr("%")
  let nameMarker = s:SVNGetOption("SVNCommandNameMarker", '_')
  let messageFileName = escape(tempname().'svn-commit.'.nameMarker.'log message'.nameMarker, ' ?*\')
  let newCwd=expand("%:h")
  let fileName=expand("%:t")

  execute 'au BufWritePost' messageFileName 'call s:SVNFinishCommit("' . messageFileName . '", "' . newCwd . '", "' . fileName . '") | au! * ' messageFileName
  execute 'au BufDelete' messageFileName 'au! * ' messageFileName

  if s:SVNEditFile(messageFileName) == -1
    execute 'au! *' messageFileName
  else
    " succeeded... turn buffer into svn commit buffer and simulate the ci
    " stuff
    set ft=svn
    let l:statuscmd = 'r!svn status '.fileName
    silent! exe l:statuscmd
    call append(0,"")
    call append(1,"--This line, and those below, will be ignored--")
    0
    let b:svnOrigBuffNR=originalBuffer
  endif
endfunction

" Function: s:SVNDiff(...) {{{2
function! s:SVNDiff(...)
  if a:0 == 1
    let revOptions = '-r' . a:1
    let caption = 'svndiff ' . a:1 . ' -> current'
  elseif a:0 == 2
    let revOptions = '-r' . a:1 . ' -r' . a:2
    let caption = 'svndiff ' . a:1 . ' -> ' . a:2
  else
    let revOptions = ''
    let caption = 'svndiff'
  endif

  let svndiffopt=s:SVNGetOption('SVNCommandDiffOpt', '')

  if svndiffopt == ""
    let diffoptionstring=""
  else
    let diffoptionstring=" -" . svndiffopt . " "
  endif

  let resultBufferName = s:SVNDoCommand('svn diff ' . diffoptionstring . revOptions , caption)
  if resultBufferName != ""
    set filetype=diff
  endif
  return resultBufferName
endfunction

" Function: s:SVNFinishCommit(messageFile, targetDir, targetFile) {{{2
function! s:SVNFinishCommit(messageFile, targetDir, targetFile)
  if filereadable(a:messageFile)
    let oldCwd=getcwd()
    if strlen(a:targetDir) > 0
      execute 'cd' escape(a:targetDir, ' ')
    endif
    let resultBufferName=s:SVNCreateCommandBuffer('0r!svn commit -F "' . a:messageFile . '" "'. a:targetFile . '"', 'svncommit', expand("%"))
    execute 'cd' escape(oldCwd, ' ')
    execute 'bw' escape(a:messageFile, ' *?\')
    silent execute '!rm' a:messageFile
    return resultBufferName
  else
    echo "Can't read message file; no commit is possible."
    return ""
  endif
endfunction

" Function: s:SVNLog() {{{2
function! s:SVNLog()
  let resultBufferName=s:SVNDoCommand('svn log', 'svnlog')
  if resultBufferName != ""
    set filetype=rcslog
  endif
  return resultBufferName
endfunction

" Function: s:SVNRevert() {{{2
function! s:SVNRevert()
  return s:SVNDoCommand('svn revert ', 'svnrevert')
endfunction

" Function: s:SVNReview(...) {{{2
function! s:SVNReview(...)
  if a:0 == 0
    let versiontag="current"
    let versionOption=""
  else
    let versiontag='r'.a:1
    let versionOption=" -r " . a:1 . " "
  endif

  let origFileType=&filetype

  let resultBufferName = s:SVNDoCommand('svn cat ' . versionOption, versiontag)

  let &filetype=origFileType
  return resultBufferName
endfunction

" Function: s:SVNStatus() {{{2
function! s:SVNStatus()
  return s:SVNDoCommand('svn status -v', 'svnstatus')
endfunction

" Function: s:SVNInfo() {{{2
function! s:SVNInfo()
  return s:SVNDoCommand('svn info', 'svninfo')
endfunction

" Function: s:SVNUpdate() {{{2
function! s:SVNUpdate()
  return s:SVNDoCommand('svn update', 'update')
endfunction

" Function: s:SVNVimDiff(...) {{{2
function! s:SVNVimDiff(...)
  let svnBufferCheck=s:SVNBufferCheck()
  if svnBufferCheck == -1 
    echo "Original buffer no longer exists, aborting."
    return ""
  endif

  " Establish split before leaving original buffer
  let splitModifier="vertical"
  if s:SVNGetOption('SVNCommandSplit', 'vertical') == 'horizontal'
    let splitModifier = ''
  endif

  let originalBuffer=bufnr("%")

  let isUsingSource=1

  if(a:0 == 0)
    let resultBufferName=s:SVNReview()
  elseif(a:0 == 1)
    let resultBufferName=s:SVNReview(a:1)
  else
    let isUsingSource=0
    let resultBufferName=s:SVNReview(a:1)
    set buftype=
    w!
    execute "au BufDelete" resultBufferName "call delete(\"".resultBufferName ."\") | au! BufDelete" resultBufferName
    execute "buffer" originalBuffer
    let originalBuffer=bufnr(resultBufferName)
    let resultBufferName=s:SVNReview(a:2)
  endif

  if isUsingSource
    " Provide for restoring state of original buffer
    execute "au BufDelete" resultBufferName "call setbufvar(" b:svnOrigBuffNR ", \"&diff\", 0)"
    execute "au BufDelete" resultBufferName "call setbufvar(" b:svnOrigBuffNR ", \"&foldcolumn\", 0)"
    execute "au BufDelete" resultBufferName "au! BufDelete " escape(resultBufferName, ' *?\')
  endif

  execute "silent leftabove" splitModifier "diffsplit" escape(bufname(originalBuffer), ' *?\')
  execute bufwinnr(originalBuffer) "wincmd w"
  return resultBufferName
endfunction

" Section: Command definitions {{{1
com! SVNAdd call s:SVNAdd()
com! -nargs=? SVNAnnotate call s:SVNAnnotate(<f-args>)
com! SVNCommit call s:SVNCommit()
com! -nargs=* SVNDiff call s:SVNDiff(<f-args>)
com! SVNLog call s:SVNLog()
com! -nargs=? SVNRevert call s:SVNRevert(<f-args>)
com! -nargs=? SVNReview call s:SVNReview(<f-args>)
com! SVNStatus call s:SVNStatus()
com! SVNInfo call s:SVNInfo()
com! SVNUpdate call s:SVNUpdate()
com! -nargs=* SVNVimDiff call s:SVNVimDiff(<f-args>)

" Section: Plugin command mappings {{{1
nnoremap <unique> <Plug>SVNAdd :SVNAdd<CR>
nnoremap <unique> <Plug>SVNAnnotate :SVNAnnotate<CR>
nnoremap <unique> <Plug>SVNCommit :SVNCommit<CR>
nnoremap <unique> <Plug>SVNDiff :SVNDiff<CR>
nnoremap <unique> <Plug>SVNLog :SVNLog<CR>
nnoremap <unique> <Plug>SVNRevert :SVNRevert<CR>
nnoremap <unique> <Plug>SVNReview :SVNReview<CR>
nnoremap <unique> <Plug>SVNStatus :SVNStatus<CR>
nnoremap <unique> <Plug>SVNInfo :SVNInfo<CR>
nnoremap <unique> <Plug>SVNUpdate :SVNUpdate<CR>
nnoremap <unique> <Plug>SVNVimDiff :SVNVimDiff<CR>

" Section: Default mappings {{{1
if !hasmapto('<Plug>SVNAdd')
  nmap <unique> <Leader>sa <Plug>SVNAdd
endif
if !hasmapto('<Plug>SVNAnnotate')
  nmap <unique> <Leader>sn <Plug>SVNAnnotate
endif
if !hasmapto('<Plug>SVNCommit')
  nmap <unique> <Leader>sc <Plug>SVNCommit
endif
if !hasmapto('<Plug>SVNDiff')
  nmap <unique> <Leader>sd <Plug>SVNDiff
endif
if !hasmapto('<Plug>SVNLog')
  nmap <unique> <Leader>sl <Plug>SVNLog
endif
if !hasmapto('<Plug>SVNRevert')
  nmap <unique> <Leader>sq <Plug>SVNRevert
endif
if !hasmapto('<Plug>SVNReview')
  nmap <unique> <Leader>sr <Plug>SVNReview
endif
if !hasmapto('<Plug>SVNStatus')
  nmap <unique> <Leader>ss <Plug>SVNStatus
endif
if !hasmapto('<Plug>SVNInfo')
  nmap <unique> <Leader>si <Plug>SVNInfo
endif
if !hasmapto('<Plug>SVNUpdate')
  nmap <unique> <Leader>su <Plug>SVNUpdate
endif
if !hasmapto('<Plug>SVNVimDiff')
  nmap <unique> <Leader>sv <Plug>SVNVimDiff
endif

" Section: Menu items {{{1
amenu <silent> &Plugin.SVN.&Add      <Plug>SVNAdd
amenu <silent> &Plugin.SVN.A&nnotate <Plug>SVNAnnotate
amenu <silent> &Plugin.SVN.&Commit   <Plug>SVNCommit
amenu <silent> &Plugin.SVN.&Diff     <Plug>SVNDiff
amenu <silent> &Plugin.SVN.&Log      <Plug>SVNLog
amenu <silent> &Plugin.SVN.Revert    <Plug>SVNRevert
amenu <silent> &Plugin.SVN.&Review   <Plug>SVNReview
amenu <silent> &Plugin.SVN.&Status   <Plug>SVNStatus
amenu <silent> &Plugin.SVN.&Info     <Plug>SVNInfo
amenu <silent> &Plugin.SVN.&Update   <Plug>SVNUpdate
amenu <silent> &Plugin.SVN.&VimDiff  <Plug>SVNVimDiff
