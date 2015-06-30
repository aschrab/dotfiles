if has("gui_macvim")
  colorscheme nuvola

  AirlineTheme lucius
  if has(":AirlineTheme")
  endif

  macm File.New\ Window					key=<Nop>
  macm File.New\ Tab					key=<Nop>
  macm File.Open\.\.\.					key=<Nop>
  macm File.Open\ Tab\.\.\.<Tab>:tabnew			key=<Nop>
  macm File.Close\ Window<Tab>:qa			key=<Nop>
  macm File.Close					key=<Nop>
  macm File.Save<Tab>:w					key=<Nop>
  macm File.Save\ All					key=<Nop>
  macm File.Save\ As\.\.\.<Tab>:sav			key=<Nop>
  macm File.Print					key=<Nop>
  macm Edit.Undo<Tab>u					key=<Nop>
  macm Edit.Redo<Tab>^R					key=<Nop>
  macm Edit.Cut<Tab>"+x					key=<Nop>
  macm Edit.Copy<Tab>"+y				key=<Nop>
  macm Edit.Paste<Tab>"+gP				key=<Nop>
  macm Edit.Select\ All<Tab>ggVG			key=<Nop>
  macm Edit.Find.Find\.\.\.				key=<Nop>
  macm Edit.Find.Find\ Next				key=<Nop>
  macm Edit.Find.Find\ Previous				key=<Nop>
  macm Edit.Find.Use\ Selection\ for\ Find		key=<Nop>
  macm Edit.Font.Bigger					key=<Nop>
  macm Edit.Font.Smaller				key=<Nop>
  macm Edit.Special\ Characters\.\.\.			key=<Nop>
  macm Tools.Spelling.To\ Next\ error<Tab>]s		key=<Nop>
  macm Tools.Spelling.Suggest\ Corrections<Tab>z=	key=<Nop>
  macm Tools.Make<Tab>:make				key=<Nop>
  macm Tools.List\ Errors<Tab>:cl			key=<Nop>
  macm Tools.Next\ Error<Tab>:cn			key=<Nop>
  macm Tools.Previous\ Error<Tab>:cp			key=<Nop>
  macm Tools.Older\ List<Tab>:cold			key=<Nop>
  macm Tools.Newer\ List<Tab>:cnew			key=<Nop>
  macm Window.Minimize					key=<Nop>
  macm Window.Minimize\ All				key=<Nop>
  macm Window.Zoom					key=<Nop>
  macm Window.Zoom\ All					key=<Nop>
  macm Window.Toggle\ Full\ Screen\ Mode		key=<Nop>
  macm Window.Select\ Next\ Tab				key=<Nop>
  macm Window.Select\ Previous\ Tab			key=<Nop>

  " Add No-op bindings for Cmd+<letter>, otherwise they act as if Cmd wasn't used
  for c in split('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789','\zs')
    exe 'map <D-' . c . '> <Nop>'
  endfor
endif

" vim: tabstop=8
