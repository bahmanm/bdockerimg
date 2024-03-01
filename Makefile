SHELL := /usr/bin/env bash
.DEFAULT_TARGET = test

####################################################################################################

root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
sources.dir := $(root.dir)src/
tests.dir := $(root.dir)tests/

####################################################################################################

.PHONY : test

test :
	@echo Dummy test target

####################################################################################################

.PHONY : build

build :
	@echo Dummy build target


####################################################################################################

.PHONY : publish

publish :
	@echo Dummy publish target
