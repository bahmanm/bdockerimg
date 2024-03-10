SHELL := /usr/bin/env bash
.DEFAULT_TARGET = test

####################################################################################################

root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
root.repository := bdockerimg
root.image-variants := ubuntu-2204 opensuse-tumbleweed
root.image-variants.default := ubuntu-2204

####################################################################################################

.PHONY : bmakelib/bmakelib.mk
include  bmakelib/bmakelib.mk

####################################################################################################

subprojects := quicklisp bmakelib sdkman
subprojects.makefiles := $(subprojects:%=$(root.dir)%/Makefile)

.PHONY : $(subprojects.makefiles)
include  $(subprojects.makefiles)

####################################################################################################

.PHONY : fusion/Makefile
include  fusion/Makefile

####################################################################################################

.PHONY : test

test : $(subprojects:%=%.test)

####################################################################################################

.PHONY : build

build : $(subprojects:%=%.build)

####################################################################################################

.PHONY : publish

publish : $(subprojects:%=%.publish)
