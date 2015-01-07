" Adapted to use autoload from
" http://vorax-ide.blogspot.com/2014/06/custom-vorax-status-line.html

function! airline#extensions#vorax#init (ext)
	call a:ext.add_statusline_func('airline#extensions#vorax#apply')
	"call a:ext.add_inactive_statusline_func('airline#extensions#vorax#apply')
endfunction

" Let me choose the statusbar
let g:vorax_output_force_overwrite_status_line = 0

function! airline#extensions#vorax#outputFlags()
  let funnel = ["", "VERTICAL", "PAGEZIP", "TABLEZIP"][vorax#output#GetFunnel()]
  let append = g:vorax_output_window_append ? "APPEND" : ""
  let sticky = g:vorax_output_window_sticky_cursor ? "STICKY" : ""
  let heading = g:vorax_output_full_heading ? "HEADING" : ""
  let top = g:vorax_output_cursor_on_top ? "TOP" : ""
  return join(filter([funnel, append, sticky, heading, top], 'v:val != ""'), ' ')
endfunction

function! airline#extensions#vorax#apply (...)
  let session = '%{vorax#sqlplus#SessionOwner()}'
  let txn = '%{vorax#utils#IsOpenTxn() ? "!" . g:vorax_output_txn_marker : ""}'
  if vorax#utils#IsVoraxBuffer()
    let w:airline_section_b = get(w:, 'airline_section_b', g:airline_section_b) . session
    let w:airline_section_warning = get(w:, 'airline_section_warning', g:airline_section_warning) . txn
  endif
  if &ft == 'outputvorax'
    let lrows = '%{exists("g:vorax_limit_rows") ? " [LIMIT ROWS <=" . g:vorax_limit_rows . "] " : ""}'
    let w:airline_section_a = '%{vorax#utils#Throbber()}'
    let w:airline_section_b = airline#section#create_left([session])
    let w:airline_section_c = 'Output window'
    let w:airline_section_x = ''
    let w:airline_section_y = g:airline_section_z
    let w:airline_section_z = airline#section#create(["%{airline#extensions#vorax#outputFlags()}"])
    let w:airline_section_warning = get(w:, 'airline_section_warning', g:airline_section_warning)
    let w:airline_section_warning .= airline#section#create([lrows, txn])
  elseif (&ft == 'connvorax') || (&ft == 'explorervorax') || (&ft == 'oradocvorax')
    let w:airline_section_a = ''
    let w:airline_section_b = ''
    let w:airline_section_c = (&ft == 'connvorax' ? 'Connection Profiles' : &ft == 'explorervorax' ? 'DB Explorer' : 'Oracle Documentation')
    let w:airline_section_x = ''
    let w:airline_section_y = ''
    let w:airline_section_z = ''
  endif
endfunction

" Let the statusbar as it is for inactive windows
let g:airline_inactive_collapse=0
