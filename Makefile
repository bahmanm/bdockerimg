SHELL := /usr/bin/env bash
.DEFAULT_TARGET = test

####################################################################################################

root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

.PHONY : bmakelib/bmakelib.mk
include  bmakelib/bmakelib.mk

####################################################################################################

subprojects :=
subprojects.makefiles := $(subprojects:%=$(root.dir)%/Makefile)

.PHONY : $(subprojects.makefiles)
include  $(subprojects.makefiles)

####################################################################################################

.PHONY : test

test : $(subprojects:%=%.test)
	@echo Dummy test target

####################################################################################################

.PHONY : build

build : $(subprojects:%=%.build)
	@echo Dummy build target


####################################################################################################

.PHONY : publish

publish : $(subprojects:%=%.publish)
	@echo Dummy publish target
