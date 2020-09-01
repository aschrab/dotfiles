java_version() {
	plutil -extract JavaVM json -o - "${1}/Contents/Info.plist" | jq -r .JVMPlatformVersion
}

java_home() {
	local version="$1"
	local verbose="${2:-n}"
	local base=/Library/Java/JavaVirtualMachines
	local jvm
	local found
	local jvm_version

	for jvm in "$base"/*
	do
		jvm_version=$(java_version "$jvm")
		[ "$verbose" = y ] && echo "Found $jvm_version in '$jvm'"
		if [ "$jvm_version" = "$version" ]; then
			found=$jvm
			break
		fi
	done

	if [ -z "$found" ]; then
		echo "No JVM found for version '$version'" >&2
		return 1
	fi

	export JAVA_HOME="${jvm}/Contents/Home"
}
