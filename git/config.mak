DEVELOPER := 1

DEFAULT_TEST_TARGET := prove
GIT_PROVE_OPTS := -j 8 --state=slow,save

CURRENT_BRANCH := $(shell git symbolic-ref --short HEAD)

ifeq ($(prefix),$(HOME))
  ifeq ($(CURRENT_BRANCH),next)
    prefix = $(HOME)/opt/git/next
  endif
  ifeq ($(CURRENT_BRANCH),pu)
    prefix = $(HOME)/opt/git/pu
  endif
endif
