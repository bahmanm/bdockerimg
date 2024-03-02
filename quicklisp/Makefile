quicklisp.root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

quicklisp.image-name := quicklisp
quicklisp.repository := $(root.repository)/$(quicklisp.image-name)
quicklisp.image-variants := opensuse-tumbleweed ubuntu-2204

####################################################################################################

# 1: image-variant
define quicklisp.image-variant.local-tag
$(quicklisp.repository):$(1)
endef

####################################################################################################

# 1: image-variant
# 2: sbcl-version
define quicklisp.image-variant.remote-tag
$(quicklisp.repository):sbcl-$(2)--$(1)
endef

####################################################################################################

# 1: image-variant
define quicklisp.publish.image-variant__generate
quicklisp.$(1).local-tag = $$(call quicklisp.image-variant.local-tag,$(1))
quicklisp.$(1).sbcl-version = $$(call quicklisp.image-variant.sbcl-version,$$(quicklisp.$(1).local-tag))
quicklisp.$(1).remote-tag = $$(call quicklisp.image-variant.remote-tag,$(1),$$(quicklisp.$(1).sbcl-version))


.PHONY : quicklisp.publish.image-variant.$(1)

quicklisp.publish.image-variant.$(1) :
	docker tag $$(quicklisp.$(1).local-tag) $$(quicklisp.$(1).remote-tag) \
	&& docker push $$(quicklisp.$(1).remote-tag)
endef

####################################################################################################

# 1: local-tag
define quicklisp.image-variant.sbcl-version
$(call bmakelib.shell.error-if-nonzero,\
	docker run --rm $(1) --version | perl -nE'say $$$$1 if /SBCL\s+(\d+\.\d+\.\d+).*/')
endef

####################################################################################################

.PHONY : quicklisp.test

quicklisp.test : quicklisp.build
quicklisp.test : $(quicklisp.image-variants:%=quicklisp.test.image-variant.%)

####################################################################################################

quicklisp.test.image-variant.% :
	$(quicklisp.root.dir)test-suite $(call quicklisp.image-variant.local-tag,$(*))

####################################################################################################

.PHONY : quicklisp.build

quicklisp.build : $(quicklisp.image-variants:%=quicklisp.build.image-variant.%)

####################################################################################################

# 1: image-variant
define quicklisp.build.image-variant
docker build \
	--tag $(call quicklisp.image-variant.local-tag,$(1)) \
	--file $(quicklisp.root.dir)Dockerfile.$(1) \
	$(quicklisp.root.dir)
endef

####################################################################################################

quicklisp.build.image-variant.% :
	$(call quicklisp.build.image-variant,$(*))

####################################################################################################

.PHONY : quicklisp.publish

quicklisp.publish : quicklisp.test
quicklisp.publish : bmakelib.default-if-blank( quicklisp.tag,latest )
quicklisp.publish : $(quicklisp.image-variants:%=quicklisp.publish.image-variant.%)

$(foreach img,$(quicklisp.image-variants),\
	$(eval $(call quicklisp.publish.image-variant__generate,$(img))))

####################################################################################################
