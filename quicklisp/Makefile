quicklisp.root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

quicklisp.image-name := quicklisp
quicklisp.repository := $(root.repository)/$(quicklisp.image-name)
quicklisp.image-variants := opensuse-tumbleweed ubuntu-2204

####################################################################################################

.PHONY : quicklisp.test

quicklisp.test :
	@echo $(@): No tests to run.

####################################################################################################

.PHONY : quicklisp.build

quicklisp.build : bmakelib.default-if-blank( quicklisp.tag,latest )
quicklisp.build : $(quicklisp.image-variants:%=quicklisp.build.image-variant.%)

####################################################################################################

define quicklisp.build.image-variant
docker build \
	--tag $(quicklisp.repository):$(quicklisp.tag)-$(1) \
	--file $(quicklisp.root.dir)Dockerfile.$(1) \
	$(quicklisp.root.dir)
endef

####################################################################################################

quicklisp.build.image-variant.% :
	$(call quicklisp.build.image-variant,$(*))

####################################################################################################

.PHONY : quicklisp.publish

quicklisp.publish : bmakelib.default-if-blank( quicklisp.tag,latest )
quicklisp.publish : $(quicklisp.image-variants:%=quicklisp.publish.image-variant.%)

####################################################################################################

define quicklisp.publish.image-variant
docker push $(quicklisp.repository):$(quicklisp.tag)-$(1)
endef

####################################################################################################

quicklisp.publish.image-variant.% :
	$(call quicklisp.publish.image-variant,$(*))
