if has("gui_macvim")
  colorscheme nuvola

  silent! set macligatures

  silent! macm File.New\ Window					key=<Nop>
  silent! macm File.New\ Tab					key=<Nop>
  silent! macm File.Open\.\.\.					key=<Nop>
  silent! macm File.Open\ Tab\.\.\.<Tab>:tabnew			key=<Nop>
  silent! macm File.Close\ Window<Tab>:qa			key=<Nop>
  silent! macm File.Close					key=<Nop>
  silent! macm File.Save<Tab>:w					key=<Nop>
  silent! macm File.Save\ All					key=<Nop>
  silent! macm File.Save\ As\.\.\.<Tab>:sav			key=<Nop>
  silent! macm File.Print					key=<Nop>
  silent! macm Edit.Undo<Tab>u					key=<Nop>
  silent! macm Edit.Redo<Tab>^R					key=<Nop>
  silent! macm Edit.Cut<Tab>"+x					key=<Nop>
  silent! macm Edit.Copy<Tab>"+y				key=<Nop>
  silent! macm Edit.Paste<Tab>"+gP				key=<Nop>
  silent! macm Edit.Select\ All<Tab>ggVG			key=<Nop>
  silent! macm Edit.Find.Find\.\.\.				key=<Nop>
  silent! macm Edit.Find.Find\ Next				key=<Nop>
  silent! macm Edit.Find.Find\ Previous				key=<Nop>
  silent! macm Edit.Find.Use\ Selection\ for\ Find		key=<Nop>
  silent! macm Edit.Font.Bigger					key=<Nop>
  silent! macm Edit.Font.Smaller				key=<Nop>
  silent! macm Edit.Special\ Characters\.\.\.			key=<Nop>
  silent! macm Tools.Spelling.To\ Next\ error<Tab>]s		key=<Nop>
  silent! macm Tools.Spelling.Suggest\ Corrections<Tab>z=	key=<Nop>
  silent! macm Tools.Make<Tab>:make				key=<Nop>
  silent! macm Tools.List\ Errors<Tab>:cl			key=<Nop>
  silent! macm Tools.Next\ Error<Tab>:cn			key=<Nop>
  silent! macm Tools.Previous\ Error<Tab>:cp			key=<Nop>
  silent! macm Tools.Older\ List<Tab>:cold			key=<Nop>
  silent! macm Tools.Newer\ List<Tab>:cnew			key=<Nop>
  silent! macm Window.Minimize					key=<Nop>
  silent! macm Window.Minimize\ All				key=<Nop>
  silent! macm Window.Zoom					key=<Nop>
  silent! macm Window.Zoom\ All					key=<Nop>
  silent! macm Window.Toggle\ Full\ Screen\ Mode		key=<Nop>
  silent! macm Window.Select\ Next\ Tab				key=<Nop>
  silent! macm Window.Select\ Previous\ Tab			key=<Nop>

  " Add No-op bindings for Cmd+<letter>, otherwise they act as if Cmd wasn't used
  for c in split('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789','\zs')
    exe 'map <D-' . c . '> <Nop>'
    exe 'cmap <D-' . c . '> <Nop>'
  endfor
endif

" vim: tabstop=8
