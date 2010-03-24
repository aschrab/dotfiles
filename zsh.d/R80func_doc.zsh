# doc function to display docs for a package, with completion
if [[ -d /doc ]]; then
  doc() { cd /doc/$1 && ls }
  _doc() { _files -W /doc -/ }
else
  doc() { cd /usr/share/doc/$1 && ls }
  _doc() { _files -W /usr/share/doc -/ }
fi
compdef _doc doc
