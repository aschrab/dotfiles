"
" Useful buffer, file and window related functions.
"
" Author: Hari Krishna Dara <hari_vim@yahoo.com>
" Last Modified: 09-Aug-2002 @ 19:51
" Requires: Vim-6.0, multvals.vim(2.0.5)
" Version: 1.1.0
" Download From:
"     http://vim.sourceforge.net/scripts/script.php?script_id=197
" Description:
"   - Scriptlets, g:makeArgumentString and g:makeArgumentList, and a function
"     CreateArgString() to work with and pass variable number of arguments to
"     other functions.
"   - Misc. window/buffer related functions, NumberOfWindows(),
"     FindWindowForBuffer(), FindBufferForName(), MoveCursorToWindow(),
"     MoveCurLineToWinLine(), SetupScratchBuffer(), MapAppendCascaded()
"   - Save/Restore all the window height/width settings to be restored later.
"   - Save/Restore position in the buffer to be restored later. Works like the
"     built-in marks feature, but has more to it.
"   - NotifyWindowClose() to get notifications *after* a window with the
"     specified buffer has been closed or the buffer is unloaded. The built-in
"     autocommands can only notify you *before* the window is closed. You can
"     use this with the Save/Restore window settings feature to restore the
"     user windows, after your window is closed. I have used this utility in
"     selectbuf.vim to restore window dimensions after the browser window is
"     closed. To add your function to be notified when a window is closed, use
"     the function:
"
"         function! AddNotifyWindowClose(windowTitle, functionName)
"
"     There is also a test function called RunNotifyWindowCloseTest() that
"     demos the usage.
"   - ShowLinesWithSyntax() function to echo lines with syntax coloring.
"   - ShiftWordInSpace(), CenterWordInSpace() and
"     AlignWordWithWordInPreviousLine() utility functions to move words in the
"     space without changing the width of the field.
"   - A quick-sort function that can sort a buffer contents by range. Adds
"     utility commands SortByLength and RSortByLength to sort contents by line
"     length.
"   - A useful ExecMap() function to facilitate recovering from typing errors
"     in normal mode mappings (see below for examples). Normally when you make
"     mistakes in typing normal mode commands, vim beeps at you and aborts the
"     command. But this method allows you to continue typing the command and
"     even backspace on errors.
"   - A sample function to extract the scriptId of a script.
"   - New CommonPath() function to extract the common part of two paths, and
"     RelPathFromFile() and RelPathFromDir() to find relative paths (useful
"     HTML href's)
"   - Functions to have persistent data, PutPersistentVar() and
"     GetPersistentVar(). You don't need to worry about saving in files and
"     reading them back. To disable, set g:genutilsNoPersist in your vimrc.
"
"     Example: Put the following in a file called t.vim in your plugin
"     directory and watch the magic. You can set new value using SetVar() and
"     see that it returns the same value across session when GetVar() is
"     called.
"     >>>>t.vim<<<<
"	au VimEnter * call LoadSettings()
"	au VimLeavePre * call SaveSettings()
"	
"	function! LoadSettings()
"	  let s:tVar = GetPersistentVar("T", "tVar", "defVal")
"	endfunction
"	
"	function! SaveSettings()
"	  call PutPersistentVar("T", "tVar", s:tVar)
"	endfunction
"	
"	function! SetVar(val)
"	  let s:tVar = a:val
"	endfunction
"	
"	function! GetVar()
"	  return s:tVar
"	endfunction
"     <<<<t.vim>>>>
"
"   - Place the following  in your vimrc if you find them useful:
"
"       command! DiffOff :call CleanDiffOptions()
"       
"       command! -nargs=0 -range=% SortByLength <line1>,<line2>call QSort(
"           \ 's:CmpByLineLength', 1)
"       command! -nargs=0 -range=% RSortByLength <line1>,<line2>call QSort(
"           \ 's:CmpByLineLength', -1)
"
"	nnoremap \ :call ExecMap('\')<CR>
"	nnoremap _ :call ExecMap('_')<CR>
"
"	nnoremap <silent> <C-Space> :call ShiftWordInSpace(1)<CR>
"	nnoremap <silent> <C-BS> :call ShiftWordInSpace(-1)<CR>
"	nnoremap <silent> \cw :call CenterWordInSpace()<CR>
"
"	nnoremap <silent> \va :call AlignWordWithWordInPreviousLine()<CR>
" TODO:
"   - fnamemodify() on Unix doesn't expand to full name if a name containing
"     path components is passed in.
"

if exists("loaded_genutils")
  finish
endif
let loaded_genutils = 1

" Execute this following variable in your function to make a string containing
"   all your arguments. The string can be used to pass the variable number of
"   arguments received by your script further down into other functions.
" Uses __argCounter and __nextArg variables, so make sure you don't have
"   variables with the same name. 
" Ex:
"   fu! s:IF(...)
"     exec g:makeArgumentString
"     exec "call Impl(" . argumentString . ")"
"   endfu
let makeArgumentString = "
    \  let __argCounter = 1\n
    \  let argumentString = ''\n
    \  while __argCounter <= a:0\n
    \    let __nextArg = substitute(a:{__argCounter},
             \ \"'\", \"' . \\\"'\\\" . '\", \"g\")\n
    \    let argumentString = argumentString . \"'\" . __nextArg . \"'\" .
             \ ((__argCounter == a:0) ? '' : ', ')\n
    \    let __argCounter = __argCounter + 1\n
    \  endwhile\n
    \  unlet __argCounter\n
    \  silent! exec 'unlet __nextArg'\n
    \ "


" Creates a argumentList string containing all the arguments separated by
"   commas.  You can then pass this string to CreateArgString() function below
"   to make argumentString which can be used as mentioned above in
"   "exec g:makeArgumentString". You can also use the scripts that let you
"   handle arrays to manipulate this string (such as remove/insert args)
"   before passing it on.
" Uses __argCounter and __argSeparator variables, so make sure you don't have
"   variables with the same name. You set the __argSeparator before executing
"   this scriptlet to make it use a different separator.
let makeArgumentList = "
    \  let __argCounter = 1\n
    \  if (! exists('__argSeparator'))\n
    \    let __argSeparator = ','\n
    \  endif\n
    \  let argumentList = ''\n
    \  while __argCounter <= a:0\n
    \    let argumentList = argumentList . a:{__argCounter}\n
    \    if __argCounter != a:0\n
    \      let argumentList = argumentList . __argSeparator\n
    \    endif\n
    \    let __argCounter = __argCounter + 1\n
    \  endwhile\n
    \  unlet __argCounter\n
    \  unlet __argSeparator\n
    \ "


" You should make sure that the separator doesn't exist in the argList. You
" can use the return value the same as the argumentString created by the
" "exec g:makeArgumentString" above.
" Usage:
"     let args = 'a b c' 
"     exec "call F(" . ConvertToArgString(args, ' ') . ")"
function! CreateArgString(argList, sep)
  let argString = a:argList
  if a:sep != "'"
    let argString = substitute(argString, "'", "' . \"'\" . '", 'g')
  endif
  let argString = substitute(argString, a:sep . '\?\([^' . a:sep . ']*\)',
	\ "'\\1', ", 'g')
  return argString
endfunction


"
" Return the number of windows open currently.
"
function! NumberOfWindows()
  let i = 1
  while winbufnr(i) != -1
    let i = i+1
  endwhile
  return i - 1
endfunction

"
" Find the window number for the buffer passed. If checkUnlisted is non-zero,
"   then it searches for the buffer in the unlisted buffers, to work-around
"   the vim bug that bufnr() doesn't work for unlisted buffers. It also
"   unprotects any extra back-slashes from the bufferName, for the sake of
"   comparision with the existing buffer names.
"
function! FindWindowForBuffer(bufferName, checkUnlisted)
  let bufno = bufnr(a:bufferName)
  " bufnr() will not find unlisted buffers.
  if bufno == -1 && a:checkUnlisted
    " Iterate over all the open windows for 

    " The window name could be having extra backslashes to protect certain
    " chars, so first expand them.
    let bufName = DeEscape(a:bufferName)
    let i = 1
    while winbufnr(i) != -1
      if bufname(winbufnr(i)) == bufName
        return i;
      endif
      let i = i + 1
    endwhile
  endif
  return bufwinnr(bufno)
endfunction

" Returns the buffer number of the given fileName if it is already loaded.
" Works around the bug in bufnr().
function! FindBufferForName(fileName)
  let i = bufnr(a:fileName)
  if i != -1
    return i
  endif

  " If bufnr didn't work, the it probably is a hidden buffer, so check the
  "   hidden buffers.
  let i = 1
  while i <= bufnr("$")
    if bufexists(i) && ! buflisted(i) && (match(bufname(i), a:fileName) != -1)
      break
    endif
    let i = i + 1
  endwhile
  if i <= bufnr("$")
    return i
  else
    return -1
  endif
endfunction


" Given the window number, moves the cursor to that window.
function! MoveCursorToWindow(winno)
  if NumberOfWindows() != 1
    execute a:winno . " wincmd w"
  endif
endfunction


" Moves the current line such that it is going to be the nth line in the window
"   without changing the column position.
function! MoveCurLineToWinLine(n)
  normal zt
  execute "normal " . a:n . "\<C-Y>"
endfunction


" Turn on some buffer settings that make it suitable to be a scratch buffer.
function! SetupScratchBuffer()
  setlocal noswapfile
  setlocal nobuflisted
  setlocal buftype=nofile
  " Just in case, this will make sure we are always hidden.
  setlocal bufhidden=delete
endfunction


" Turns off those options that are set by diff to the current window.
"   Also removes the 'hor' option from scrollopt (which is a global option).
" Better alternative would be to close the window and reopen the buffer in a
"   new window. 
function! CleanDiffOptions()
  setlocal nodiff
  setlocal noscrollbind
  setlocal scrollopt-=hor
  setlocal wrap
  setlocal foldmethod=manual
  setlocal foldcolumn=0
endfunction


" This function is an alternative to exists() function, for those odd array
"   index names for which the built-in function fails. The var should be
"   accessible to this functions, so it should be a global variable.
"     if ArrayVarExists("array", id)
"       let val = array{id}
"     endif
function! ArrayVarExists(varName, index)
  let v:errmsg = ""
  silent! exec "let test = " . a:varName . "{a:index}"
  if !exists("test") || test == ""
    return 0
  endif
  return 1
endfunction


" Works like the reverse of the builtin escape() function.
function! DeEscape(val)
  exec "let val = \"" . a:val . "\"" 
  return val
endfunction


" Returns 1 if preview window is open or 0 if not.
function! IsPreviewWindowOpen()
  let v:errmsg = ""
  silent! exec "wincmd P"
  if v:errmsg != ""
    return 0
  else
    wincmd p
    return 1
  endif
endfunction


"
" Saves the heights and widths of the currently open windows for restoring
"   later.
"
function! SaveWindowSettings()
  call SaveWindowSettings2(s:myScriptId, 1)
endfunction


"
" Restores the heights of the windows from the information that is saved by
"  SaveWindowSettings().
"
function! RestoreWindowSettings()
  call RestoreWindowSettings2(s:myScriptId)
endfunction


function! ResetWindowSettings()
  call ResetWindowSettings2(s:myScriptId)
endfunction


" Same as SaveWindowSettings, but uses the passed in scriptid to create a
"   private copy for the calling script. Pass in a unique scriptid to avoid
"   conflicting with other callers. If overwrite is zero and if the settings
"   are already stored for the passed in sid, it will overwriting previously
"   saved settings.
function! SaveWindowSettings2(sid, overwrite)
  if ArrayVarExists("s:winSettings", a:sid) && ! a:overwrite
    return
  endif

  let s:winSettings{a:sid} = ""
  let s:winSettings{a:sid} = MvAddElement(s:winSettings{a:sid}, ",",
          \ NumberOfWindows())
  let s:winSettings{a:sid} = MvAddElement(s:winSettings{a:sid}, ",", &lines)
  let s:winSettings{a:sid} = MvAddElement(s:winSettings{a:sid}, ",", &columns)
  let s:winSettings{a:sid} = MvAddElement(s:winSettings{a:sid}, ",", winnr())
  let i = 1
  while winbufnr(i) != -1
    let s:winSettings{a:sid} = MvAddElement(s:winSettings{a:sid}, ",",
            \ winheight(i))
    let s:winSettings{a:sid} = MvAddElement(s:winSettings{a:sid}, ",",
            \ winwidth(i))
    let i = i + 1
  endwhile
  "let g:savedWindowSettings = s:winSettings{a:sid} " Debug.
endfunction


" Same as RestoreWindowSettings, but uses the passed in scriptid to get the
"   settings.
function! RestoreWindowSettings2(sid)
  "if ! exists("s:winSettings" . a:sid)
  if ! ArrayVarExists("s:winSettings", a:sid)
    return
  endif

  call MvIterCreate(s:winSettings{a:sid}, ",", "savedWindowSettings")
  let nWindows = MvIterNext("savedWindowSettings")
  if nWindows != NumberOfWindows()
    unlet s:winSettings{a:sid}
    call MvIterDestroy("savedWindowSettings")
    return
  endif
  let orgLines = MvIterNext("savedWindowSettings")
  let orgCols = MvIterNext("savedWindowSettings")
  let activeWindow = MvIterNext("savedWindowSettings")
  
  let winNo = 1
  while MvIterHasNext("savedWindowSettings")
    let height = MvIterNext("savedWindowSettings")
    let width = MvIterNext("savedWindowSettings")
    call MoveCursorToWindow(winNo)
    exec 'resize ' . ((&lines * height + (orgLines / 2)) / orgLines)
    exec 'vert resize ' . ((&columns * width + (orgCols / 2)) / orgCols)
    let winNo = winNo + 1
  endwhile
  
  " Restore the current window.
  call MoveCursorToWindow(activeWindow)
  call ResetWindowSettings2(a:sid)
  "unlet g:savedWindowSettings " Debug.
  call MvIterDestroy("savedWindowSettings")
endfunction


function! ResetWindowSettings2(sid)
  if ! ArrayVarExists("s:winSettings", a:sid)
    unlet s:winSettings{a:sid}
  endif
endfunction


" Cleanup file name such that two *cleaned up* file names are easy to be
"   compared. This probably works only on windows and unix platforms.
function! CleanupFileName(fileName)
  let fileName = a:fileName

  " If filename starts with an ~.
  " The below case takes care of this also.
  "if match(fileName, '^\~') == 0
  "  let fileName = substitute(fileName, '^\~', escape($HOME, '\'), '')
  "endif

  " Expand relative paths and paths containing relative components.
  if ! PathIsAbsolute(fileName)
    let fileName = fnamemodify(fileName, ":p")
  endif

  " Remove multiple path separators.
  if has("win32")
    let fileName=substitute(fileName, '\\', '/', "g")
  elseif OnMS()
    let fileName=substitute(fileName, '\\\{2,}', '\', "g")
  endif
  let fileName=substitute(fileName, '/\{2,}', '/', "g")

  " Remove ending extra path separators.
  let fileName=substitute(fileName, '/$', '', "")
  let fileName=substitute(fileName, '\$', '', "")

  if OnMS()
    let fileName=substitute(fileName, '^[A-Z]:', '\L&', "")

    " Add drive letter if missing (just in case).
    if match(fileName, '^/') == 0
      let curDrive = substitute(getcwd(), '^\([a-zA-Z]:\).*$', '\L\1', "")
      let fileName = curDrive . fileName
    endif
  endif
  return fileName
endfunction
"echo CleanupFileName('\\a///b/c\')
"echo CleanupFileName('C:\a/b/c\d')
"echo CleanupFileName('a/b/c\d')
"echo CleanupFileName('~/a/b/c\d')
"echo CleanupFileName('~/a/b/../c\d')


function! OnMS()
  return has("win32") || has("dos32") || has("win16") || has("dos16") ||
       \ has("win95")
endfunction


function! PathIsAbsolute(path)
  let absolute=0
  if has("unix") || OnMS()
    if match(a:path, "^/") == 0
      let absolute=1
    endif
  endif
  if (! absolute) && OnMS()
    if match(a:path, "^\\") == 0
      let absolute=1
    endif
  endif
  if (! absolute) && OnMS()
    if match(a:path, "^[A-Za-z]:") == 0
      let absolute=1
    endif
  endif
  return absolute
endfunction


function! PathIsFileNameOnly(path)
  return (match(a:path, "\\") < 0) && (match(a:path, "/") < 0)
endfunction


" Copy this method into your script and rename it to find the script id of the
"   current script.
function! SampleScriptIdFunction()
  map <SID>xx <SID>xx
  let s:sid = maparg("<SID>xx")
  unmap <SID>xx
  return substitute(s:sid, "xx$", "", "")
endfunction
let s:myScriptId = SampleScriptIdFunction()


""
"" --- START save/restore position.
""

" characters that must be escaped for a regular expression
let s:escregexp = '/*^$.~\'


" This method tries to save the position along with the line context if
"   possible. This is like the vim builtin marker. Pass in a unique scriptid
"   to avoid conflicting with other callers.
function! SaveSoftPosition(scriptid)
  let s:startline_{a:scriptid} = getline(".")
  call SaveHardPosition(a:scriptid)
endfunction


function! RestoreSoftPosition(scriptid)
  0
  if search('\m^'.escape(s:startline_{a:scriptid},s:escregexp),'W') <= 0
    call RestoreHardPosition(a:scriptid)
  else
    execute "normal!" s:col_{a:scriptid} . "|"
    call MoveCurLineToWinLine(s:winline_{a:scriptid})
  endif
endfunction


function! ResetSoftPosition(scriptid)
  unlet s:startline_{a:scriptid}
endfunction


" A synonym for SaveSoftPosition.
function! SaveHardPositionWithContext(scriptid)
  call SaveSoftPosition(a:scriptid)
endfunction


" A synonym for RestoreSoftPosition.
function! RestoreHardPositionWithContext(scriptid)
  call RestoreSoftPosition(a:scriptid)
endfunction


" A synonym for ResetSoftPosition.
function! ResetHardPositionWithContext(scriptid)
  call ResetSoftPosition(a:scriptid)
endfunction


" Useful when you want to go to the exact (line, col), but marking will not
"   work, or if you simply don't want to disturb the marks. Pass in a unique
"   scriptid.
function! SaveHardPosition(scriptid)
  let s:col_{a:scriptid} = virtcol(".")
  let s:lin_{a:scriptid} = line(".")
  let s:winline_{a:scriptid} = winline()
endfunction


function! RestoreHardPosition(scriptid)
  execute s:lin_{a:scriptid}
  execute "normal!" s:col_{a:scriptid} . "|"
  call MoveCurLineToWinLine(s:winline_{a:scriptid})
endfunction


function! ResetHardPosition(scriptid)
  unlet s:col_{a:scriptid}
  unlet s:lin_{a:scriptid}
  unlet s:winline_{a:scriptid}
endfunction

""
"" --- END save/restore position.
""



""
"" --- START: Notify window close --
""


"
" When the window with the title windowTitle is closed, the global function
"   functionName is called with the title as an argument, and the entries are
"   removed, so if you are still interested, you need to register again.
"
function! AddNotifyWindowClose(windowTitle, functionName)
  " The window name could be having extra backslashes to protect certain
  " chars, so first expand them.
  let bufName = DeEscape(a:windowTitle)

  " Make sure there is only one entry per window title.
  if exists("s:notifyWindowTitles") && s:notifyWindowTitles != ""
    call RemoveNotifyWindowClose(bufName)
  endif

  if !exists("s:notifyWindowTitles")
    " Both separated by :.
    let s:notifyWindowTitles = ""
    let s:notifyWindowFunctions = ""
  endif

  let s:notifyWindowTitles = MvAddElement(s:notifyWindowTitles, ";", bufName)
  let s:notifyWindowFunctions = MvAddElement(s:notifyWindowFunctions, ";",
          \ a:functionName)

  let g:notifyWindowTitles = s:notifyWindowTitles " Debug.
  let g:notifyWindowFunctions = s:notifyWindowFunctions " Debug.

  " Start listening to events.
  aug NotifyWindowClose
    au!
    au WinEnter * :call CheckWindowClose()
  aug END
endfunction


function! RemoveNotifyWindowClose(windowTitle)
  " The window name could be having extra backslashes to protect certain
  " chars, so first expand them.
  let bufName = DeEscape(a:windowTitle)

  if !exists("s:notifyWindowTitles")
    return
  endif

  if MvContainsElement(s:notifyWindowTitles, ";", bufName)
    let index = MvIndexOfElement(s:notifyWindowTitles, ";", bufName)
    let s:notifyWindowTitles = MvRemoveElementAt(s:notifyWindowTitles, ";",
            \ index)
    let s:notifyWindowFunctions = MvRemoveElementAt(s:notifyWindowFunctions,
            \ ";", index)

    if s:notifyWindowTitles == ""
      unlet s:notifyWindowTitles
      unlet s:notifyWindowFunctions
      unlet g:notifyWindowTitles " Debug.
      unlet g:notifyWindowFunctions " Debug.
  
      aug NotifyWindowClose
        au!
      aug END
    endif
  endif
endfunction


function! CheckWindowClose()
  if !exists("s:notifyWindowTitles")
    return
  endif

  " First make an array with all the existing window titles.
  let i = 1
  let currentWindows = ""
  while winbufnr(i) != -1
    let bufname = bufname(winbufnr(i))
    if bufname != ""
      let currentWindows = MvAddElement(currentWindows, ";", bufname)
    endif
    let i = i+1
  endwhile
  "call input("currentWindows: " . currentWindows)

  " Now iterate over all the registered window titles and see which one's are
  "   closed.
  let i = 0 " To track the element index.
  " Take a copy and modify these if needed, as we are not supposed to modify
  "   the main arrays while iterating over them.
  let processedElements = ""
  call MvIterCreate(s:notifyWindowTitles, ";", "NotifyWindowClose")
  while MvIterHasNext("NotifyWindowClose")
    let nextWin = MvIterNext("NotifyWindowClose")
    if ! MvContainsElement(currentWindows, ";", nextWin)
      let funcName = MvElementAt(s:notifyWindowFunctions, ";", i)
      let cmd = "call " . funcName . "(\"" . nextWin . "\")"
      "call input("cmd: " . cmd)
      exec cmd

      " Remove these entries as these are already processed.
      let processedElements = MvAddElement(processedElements, ";", nextWin)
    endif
  endwhile
  call MvIterDestroy("NotifyWindowClose")

  call MvIterCreate(processedElements, ";", "NotifyWindowClose")
  while MvIterHasNext("NotifyWindowClose")
    let nextWin = MvIterNext("NotifyWindowClose")
    call RemoveNotifyWindowClose(nextWin)
  endwhile
  call MvIterDestroy("NotifyWindowClose")
endfunction


"function! NotifyWindowCloseF(title)
"  call input(a:title . " closed")
"endfunction
"
"function! RunNotifyWindowCloseTest()
"  split ABC
"  split XYZ
"  call AddNotifyWindowClose("ABC", "NotifyWindowCloseF")
"  call AddNotifyWindowClose("XYZ", "NotifyWindowCloseF")
"  call input("notifyWindowTitles: " . s:notifyWindowTitles)
"  call input("notifyWindowFunctions: " . s:notifyWindowFunctions)
"  au WinEnter
"  split b
"  call input("Starting the tests, you should see two notifications:")
"  quit
"  quit
"  quit
"endfunction


""
"" --- END: Notify window close --
""



"
" TODO: For large ranges, the cmd can become too big, so make it one cmd per
"         line.
" Display the given line(s) from the current file in the command area (i.e.,
" echo), using that line's syntax highlighting (i.e., WYSIWYG).
"
" If no line number is given, display the current line.
"
" Originally,
" From: Gary Holloway <gary@castandcrew.com>
" Date: Wed, 16 Jan 2002 14:31:56 -0800
"
function! ShowLinesWithSyntax() range
  " This makes sure we start (subsequent) echo's on the first line in the
  " command-line area.
  "
  echo ''

  let cmd        = ''
  let prev_group = ' x '     " Something that won't match any syntax group.

  let show_line = a:firstline
  let isMultiLine = ((a:lastline - a:firstline) > 1)
  while show_line <= a:lastline
    if (show_line - a:firstline) > 1
      let cmd = cmd . '\n'
    endif

    let length = strlen(getline(show_line))
    let column = 1

    while column <= length
      let group = synIDattr(synID(show_line, column, 1), 'name')
      if group != prev_group
        if cmd != ''
          let cmd = cmd . '"|'
        endif
        let cmd = cmd . 'echohl ' . (group == '' ? 'NONE' : group) . '|echon "'
        let prev_group = group
      endif
      let char = strpart(getline(show_line), column - 1, 1)
      if char == '"'
        let char = '\"'
      endif
      let cmd = cmd . char
      let column = column + 1
    endwhile

    let show_line = show_line + 1
  endwhile
  let cmd = cmd . '"|echohl NONE'

  let g:firstone = cmd
  exe cmd
endfunction


function! AlignWordWithWordInPreviousLine()
  "First go to the first col in the word.
  if getline('.')[col('.') - 1] =~ '\s'
    normal! w
  else
    normal! "_yiw
  endif
  let orgVcol = virtcol('.')
  let prevLnum = prevnonblank(line('.') - 1)
  if prevLnum == -1
    return
  endif
  let prevLine = getline(prevLnum)

  " First get the column to align with.
  if prevLine[orgVcol - 1] =~ '\s'
    " column starts from 1 where as index starts from 0.
    let nonSpaceStrInd = orgVcol " column starts from 1 where as index starts from 0.
    while prevLine[nonSpaceStrInd] =~ '\s'
      let nonSpaceStrInd = nonSpaceStrInd + 1
    endwhile
  else
    if strlen(prevLine) < orgVcol
      let nonSpaceStrInd = strlen(prevLine) - 1
    else
      let nonSpaceStrInd = orgVcol - 1
    endif

    while prevLine[nonSpaceStrInd - 1] !~ '\s' && nonSpaceStrInd > 0
      let nonSpaceStrInd = nonSpaceStrInd - 1
    endwhile
  endif
  let newVcol = nonSpaceStrInd + 1 " Convert to column number.

  if orgVcol > newVcol " We need to reduce the spacing.
    let sub = strpart(getline('.'), newVcol - 1, (orgVcol - newVcol))
    if sub =~ '^\s\+$'
      " Remove the excess space.
      exec 'normal! ' . newVcol . '|'
      exec 'normal! ' . (orgVcol - newVcol) . 'x'
    endif
  elseif orgVcol < newVcol " We need to insert spacing.
    exec 'normal! ' . orgVcol . '|'
    exec 'normal! ' . (newVcol - orgVcol) . 'i '
  endif
endfunction


" This function shifts the word in the space without moving the following words.
"   Doesn't work for tabs.
function! ShiftWordInSpace(dir)
  if a:dir == 1 " forward.
    " If currently on <Space>...
    if getline(".")[col(".") - 1] == " "
      let move1 = 'wf '
    else
      " If next col is a 
      "if getline(".")[col(".") + 1]
      let move1 = 'f '
    endif
    let removeCommand = "x"
    let pasteCommand = "bi "
    let move2 = 'w'
    let offset = 0
  else " backward.
    " If currently on <Space>...
    if getline(".")[col(".") - 1] == " "
      let move1 = 'w'
    else
      let move1 = '"_yiW'
    endif
    let removeCommand = "hx"
    let pasteCommand = 'h"_yiwEa '
    let move2 = 'b'
    let offset = -3
  endif

  let savedCol = col(".")
  exec "normal" move1
  let curCol = col(".")
  let possible = 0
  " Check if there is a space at the end.
  if col("$") == (curCol + 1) " Works only for forward case, as expected.
    let possible = 1
  elseif getline(".")[curCol + offset] == " "
    " Remove the space from here.
    exec "normal" removeCommand
    let possible = 1
  endif

  " Move back into the word.
  "exec "normal" savedCol . "|"
  if possible == 1
    exec "normal" pasteCommand
    exec "normal" move2
  else
    " Move to the original location.
    exec "normal" savedCol . "|"
  endif
endfunction


function! CenterWordInSpace()
  let line = getline('.')
  let orgCol = col('.')
  " If currently on <Space>...
  if line[orgCol - 1] == " "
    let matchExpr = ' *\%'. orgCol . 'c *\w\+ \+'
  else
    let matchExpr = ' \+\(\w*\%' . orgCol . 'c\w*\) \+'
  endif
  let matchInd = match(line, matchExpr)
  if matchInd == -1
    return
  endif
  let matchStr = matchstr(line,  matchExpr)
  let nSpaces = strlen(substitute(matchStr, '[^ ]', '', 'g'))
  let word = substitute(matchStr, ' ', '', 'g')
  let middle = nSpaces / 2
  let left = nSpaces - middle
  let newStr = ''
  while middle > 0
    let newStr = newStr . ' '
    let middle = middle - 1
  endwhile
  let newStr = newStr . word
  while left > 0
    let newStr = newStr . ' '
    let left = left - 1
  endwhile

  let newLine = strpart(line, 0, matchInd)
  let newLine = newLine . newStr
  let newLine = newLine . strpart (line, matchInd + strlen(matchStr))
  call setline(line('.'), newLine)
endfunction


" Reads a normal mode mapping at the command line and executes it with the
"   given prefix. Press <BS> to correct and <Esc> to cancel.
function! ExecMap(prefix)
  " Temporarily remove the mapping, otherwise it will interfere with the
  " mapcheck call below:
  let myMap = maparg(a:prefix, 'n')
  exec "nunmap" a:prefix

  " Generate a line with spaces to clear the previous message.
  let i = 1
  let clearLine = "\r"
  while i < &columns
    let clearLine = clearLine . ' '
    let i = i + 1
  endwhile

  let mapCmd = a:prefix
  let foundMap = 0
  let breakLoop = 0
  let curMatch = ''
  echon "\rEnter Map: " . mapCmd
  while !breakLoop
    let char = getchar()
    if char !~ '^\d\+$'
      if char == "\<BS>"
	let mapCmd = strpart(mapCmd, 0, strlen(mapCmd) - 1)
      endif
    else " It is the ascii code.
      let char = nr2char(char)
      if char == "\<Esc>"
	let breakLoop = 1
      "elseif char == "\<CR>"
	"let mapCmd = curMatch
	"let foundMap = 1
	"let breakLoop = 1
      else
	let mapCmd = mapCmd . char
	if maparg(mapCmd, 'n') != ""
	  let foundMap = 1
	  let breakLoop = 1
	else
	  let curMatch = mapcheck(mapCmd, 'n')
	  if curMatch == ""
	    let mapCmd = strpart(mapCmd, 0, strlen(mapCmd) - 1)
	  endif
	endif
      endif
    endif
    echon clearLine
    "echon "\rEnter Map: " . substitute(mapCmd, '.', ' ', 'g') . "\t" . curMatch
    echon "\rEnter Map: " . mapCmd
  endwhile
  if foundMap
    exec "normal" mapCmd
  endif
  exec "nnoremap" a:prefix myMap
endfunction


" If lhs is already mapped, this function makes sure rhs is appended to it
"   instead of overwriting it.
" mapMode is used to prefix to "oremap" and used as the map command. E.g., if
"   mapMode is 'n', then the function call results in the execution of noremap
"   command.
function! MapAppendCascaded(lhs, rhs, mapMode)

  " Determine the map mode from the map command.
  let mapChar = strpart(a:mapMode, 0, 1)

  " Check if this is already mapped.
  let oldrhs = maparg(a:lhs, mapChar)
  if oldrhs != ""
    let self = oldrhs
  else
    let self = a:lhs
  endif
  "echomsg a:mapMode . "oremap" . " " . a:lhs . " " . self . a:rhs
  exec a:mapMode . "oremap" a:lhs self . a:rhs
endfunction


"" 
"" Sort utilities.
""

"
" Comapare functions.
"

function! s:CmpByLineLength(line1, line2, direction)
  let len1 = strlen(a:line1)
  let len2 = strlen(a:line2)
  if (len1 == len2)
    return s:CmpByName(a:line1, a:line2, a:direction)
  else
    return a:direction * (len1 - len2)
  endif
endfunction

function! s:CmpByName(line1, line2, direction)
  if a:line1 < a:line2
    return -a:direction
  elseif a:line1 > a:line2
    return a:direction
  else
    return 0
  endif
endfunction

function! s:CmpByNumber(line1, line2, direction)
  let num1 = a:line1 + 0
  let num2 = a:line2 + 0

  if num1 < num2
    return -a:direction
  elseif num1 > num2
    return a:direction
  else
    return 0
  endif
endfunction

"" START: Sorting support. {{{
""

"
" To Sort a range of lines, pass the range to QSort() along with the name of a
" function that will compare two lines.
"
function! QSort(cmp,direction) range
  call s:QSortR(a:firstline, a:lastline, a:cmp, a:direction)
endfunction


"
" Sort lines.  SortR() is called recursively.
"
function! s:QSortR(start, end, cmp, direction)
  if a:end > a:start
    let low = a:start
    let high = a:end

    " Arbitrarily establish partition element at the midpoint of the data.
    let midStr = getline((a:start + a:end) / 2)

    " Loop through the data until indices cross.
    while low <= high

      " Find the first element that is greater than or equal to the partition
      "   element starting from the left Index.
      while low < a:end
        let str = getline(low)
        exec "let result = " . a:cmp . "(str, midStr, " . a:direction . ")"
        if result < 0
          let low = low + 1
        else
          break
        endif
      endwhile

      " Find an element that is smaller than or equal to the partition element
      "   starting from the right Index.
      while high > a:start
        let str = getline(high)
        exec "let result = " . a:cmp . "(str, midStr, " . a:direction . ")"
        if result > 0
          let high = high - 1
        else
          break
        endif
      endwhile

      " If the indexes have not crossed, swap.
      if low <= high
        " Swap lines low and high.
        let str2 = getline(high)
        call setline(high, getline(low))
        call setline(low, str2)
        let low = low + 1
        let high = high - 1
      endif
    endwhile

    " If the right index has not reached the left side of data must now sort
    "   the left partition.
    if a:start < high
      call s:QSortR(a:start, high, a:cmp, a:direction)
    endif

    " If the left index has not reached the right side of data must now sort
    "   the right partition.
    if low < a:end
      call s:QSortR(low, a:end, a:cmp, a:direction)
    endif
  endif
endfunction

""" END: Sorting support. }}}


" Eats character if it matches the given pattern.
"
" Originally,
" From: Benji Fisher <fisherbb@bc.edu>
" Date: Mon, 25 Mar 2002 15:05:14 -0500
"
" Based on Bram's idea of eating a character while type <Space> to expand an
"   abbreviation. This solves the problem with abbreviations, where we are
"   left with an extra space after the expansion.
" Ex:
"   inoreabbr \stdout\ System.out.println("");<Left><Left><Left><C-R>=EatChar('\s')<CR>
function! EatChar(pat)
   let c = nr2char(getchar())
   return (c =~ a:pat) ? '' : c
endfun


" Convert Roman numerals to decimal. Doesn't detect format errors.
"
" Originally,
" From: "Preben Peppe Guldberg" <c928400@student.dtu.dk>
" Date: Fri, 10 May 2002 14:28:19 +0200
"
" START: Roman2Decimal {{{
let s:I = 1
let s:V = 5
let s:X = 10
let s:L = 50
let s:C = 100
let s:D = 500
let s:M = 1000

fun! s:Char2Num(c)
    " A bit of magic on empty strings
    if a:c == ""
        return 0
    endif
    exec 'let n = s:' . toupper(a:c)
    return n
endfun

fun! Roman2Decimal(str)
    if a:str !~? '^[IVXLCDM]\+$'
        return a:str
    endif
    let sum = 0
    let i = 0
    let n0 = s:Char2Num(a:str[i])
    let len = strlen(a:str)
    while i < len
        let i = i + 1
        let n1 = s:Char2Num(a:str[i])
        " Magic: n1=0 when i exceeds len
        if n1 > n0
            let sum = sum - n0
        else
            let sum = sum + n0
        endif
        let n0 = n1
    endwhile
    return sum
endfun
" END: Roman2Decimal }}}


" BEGIN: Relative path {{{
" Find common path component of two filenames, based on the tread, "computing
" relative path".
" Date: Mon, 29 Jul 2002 21:30:56 +0200 (CEST)
function! CommonPath(path1, path2)
  let path1 = CleanupFileName(a:path1)
  let path2 = CleanupFileName(a:path2)
  if path1 == path2
    return path1
  endif
  let n = 0
  while path1[n] == path2[n]
    let n = n+1
  endwhile
  return strpart(path1, 0, n)
endfunction


function! RelPathFromFile(srcFile, tgtFile)
  return RelPathFromDir(fnamemodify(a:srcFile, ':r'), a:tgtFile)
endfunction


function! RelPathFromDir(srcDir, tgtFile)
  let cleanDir = CleanupFileName(a:srcDir)
  let cleanFile = CleanupFileName(a:tgtFile)
  let cmnPath = CommonPath(cleanDir, cleanFile)
  let shortDir = strpart(cleanDir, strlen(cmnPath))
  let shortFile = strpart(cleanFile, strlen(cmnPath))
  let relPath = substitute(substitute(shortDir, '[^/]\+$', '', ''),
	\ '[^/]\+', '..', 'g')
  return relPath . shortFile
endfunction

" END: Relative path }}}

" BEGIN: Persistent settings {{{
if ! exists("g:genutilsNoPersist") || ! g:genutilsNoPersist

" Make sure the '!' option to store global variables that are upper cased are
" stored in viminfo file.
set viminfo+=!

" The pluginName and persistentVar have to be unique and are case insensitive.
" Should be called from VimLeavePre. This simply creates a global variable which
"   will be persisted by Vim through viminfo. The variable can be read back in
"   the next session by the plugin using GetPersistentVar() function. The
"   pluginName is to provide a name space for different plugins, and avoid
"   conflicts in using the same persistentVar name.
" This feature uses the '!' option of viminfo, to avoid storing all the
"   temporary and other plugin specific global variables getting saved.
function! PutPersistentVar(pluginName, persistentVar, value)
  let globalVarName = s:PersistentVarName(a:pluginName, a:persistentVar)
  exec 'let ' . globalVarName . " = '" . a:value . "'"
endfunction

" Should be called from VimEnter. Simply reads the gloval variable for the
"   value and returns it. Removed the variable from global space before
"   returning the value, so should be called only once.
function! GetPersistentVar(pluginName, persistentVar, default)
  let globalVarName = s:PersistentVarName(a:pluginName, a:persistentVar)
  if (exists(globalVarName))
    exec 'let value = ' . globalVarName
    exec 'unlet ' . globalVarName
  else
    let value = a:default
  endif
  return value
endfunction

function! s:PersistentVarName(pluginName, persistentVar)
  return 'g:GU_' . toupper(a:pluginName) . '_' . toupper(a:persistentVar)
endfunction

endif
" END: Persistent settings }}}

" vim6:fdm=marker
