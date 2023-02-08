load_brew_prefix() {
	local package="$1"
  local added_bin="${2:-}"

	local top="/usr/local/Cellar/${package}"

	if ! [ -d "$top" ]; then
		echo "No Cellar entry for '$package'" >&2
		return 1
	fi


	dir=$(ls -t "$top")
	if [ -z "$dir" ]; then
		echo "Cellar is empty for '$package'" >&2
		return 1
	fi

	load_prefix "${top}/${dir}"

  if [ -n "${added_bin}" ]; then
    PATH_add "${top}/${dir}/${added_bin}"
  fi
}
