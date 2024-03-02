dummy.root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

dummy.image-name := dummy
dummy.repository := $(root.repository)/$(dummy.image-name)

####################################################################################################

.PHONY : dummy.test

dummy.test :
	@echo $(@): No tests to run.

####################################################################################################

.PHONY : dummy.build

dummy.build : bmakelib.default-if-blank( dummy.tag,latest )
dummy.build :
	docker build $(dummy.root.dir) --tag $(dummy.repository):$(dummy.tag)

####################################################################################################

.PHONY : dummy.publish

dummy.publish : bmakelib.default-if-blank( dummy.tag,latest )
	docker push $(dummy.repository):$(dummy.tag)
