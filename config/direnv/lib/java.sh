java_home() {
	local version="$1"
	local base=/Library/Java/JavaVirtualMachines
	local jvm
	local found
	local jvm_version

	for jvm in "$base"/*
	do
		jvm_version=$(plutil -extract JavaVM json -o - "${jvm}/Contents/Info.plist" | jq -r .JVMPlatformVersion)
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
