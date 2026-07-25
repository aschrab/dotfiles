DEVELOPER := 1

DEFAULT_TEST_TARGET := prove
GIT_PROVE_OPTS := -j 8 --state=slow,save

CURRENT_BRANCH := $(shell git symbolic-ref --short HEAD)

# Require curl dependency to be satisfied
NO_CURL=


SKIP_DASHED_BUILT_INS:=y

ifeq ($(prefix),$(HOME))
  prefix = $(HOME)/opt/git/$(CURRENT_BRANCH)
endif
