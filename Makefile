SHELL := /usr/bin/env bash
.DEFAULT_TARGET = test

####################################################################################################

root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
root.repository := bdockerimg

####################################################################################################

.PHONY : bmakelib/bmakelib.mk
include  bmakelib/bmakelib.mk

####################################################################################################

subprojects := sdkman
subprojects.makefiles := $(subprojects:%=$(root.dir)%/Makefile)

.PHONY : $(subprojects.makefiles)
include  $(subprojects.makefiles)

####################################################################################################

.PHONY : test

test : $(subprojects:%=%.test)

####################################################################################################

.PHONY : build

build : $(subprojects:%=%.build)

####################################################################################################

.PHONY : publish

publish : $(subprojects:%=%.publish)
