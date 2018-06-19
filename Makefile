all: ssh/config

ssh/config: ssh/config.in
	m4 --fatal-warnings $^ > $@.tmp && mv $@.tmp $@ || rm -f $@.tmp
