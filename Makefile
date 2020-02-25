all: ssh/config

%: %.m4
	m4 --fatal-warnings $^ > $@.tmp && mv $@.tmp $@ || rm -f $@.tmp
