function lyst () {
  local dir=$(builtin pwd -L)
  local proj
  local sub

  while [[ -z $proj && -n $dir ]]; do
    if [[ (-f "$dir/META.yml") && (-d "$dir/lib") && (-d "$dir/script") ]];
    then
      proj=$(sed -ne '/^name: /s///p' < $dir/META.yml)

      case "$1" in
	base)
	  sub=""
	  ;;
	templates)
	  sub=templates
	  ;;
	static)
	  sub=root/static
	  ;;
	js)
	  sub=root/static/js
	  ;;
	css)
	  sub=root/static/css
	  ;;
	lib)
	  sub=lib
	  ;;
	project)
	  sub="lib/$proj"
	  ;;
	view)
	  sub="lib/$proj/View"
	  ;;
	controller)
	  sub="lib/$proj/Controller"
	  ;;
	model)
	  sub="lib/$proj/Model"
	  ;;
	schema)
	  sub="lib/$proj/Schema"
	  ;;
	*)
	  echo "Unknown dir" >&2
	  return 2
	  ;;
      esac
    else
      dir=${dir%/*}
    fi
  done

  if [[ -z $proj ]]; then
    echo "Not in a Catalyst project directory" >&2
    return 1
  fi

  cd $dir/$sub
}

compctl -k "(base templates static js css lib project view controller model schema)" lyst
