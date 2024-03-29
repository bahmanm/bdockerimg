quicklisp.root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

quicklisp.image-name := quicklisp
quicklisp.repository := $(root.repository)/$(quicklisp.image-name)

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

# 1: local-tag
define quicklisp.image-variant.sbcl-version
$(call bmakelib.shell.error-if-nonzero,\
	docker run --rm $(1) --version | perl -nE'say $$$$1 if /SBCL\s+(\d+\.\d+\.\d+).*/')
endef

####################################################################################################

.PHONY : quicklisp.test

quicklisp.test : $(root.image-variants:%=quicklisp.test.image-variant.%)

####################################################################################################

quicklisp.test.image-variant.% :
	$(quicklisp.root.dir)test-suite $(call quicklisp.image-variant.local-tag,$(*))

####################################################################################################

.PHONY : quicklisp.build

quicklisp.build : $(root.image-variants:%=quicklisp.build.image-variant.%)

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

quicklisp.publish : bmakelib.default-if-blank( quicklisp.tag,latest )
quicklisp.publish : $(root.image-variants:%=quicklisp.publish.image-variant.%)

####################################################################################################

# 1: image-variant
define quicklisp.publish.image-variant__generate
quicklisp.$(1).local-tag = $$(call quicklisp.image-variant.local-tag,$(1))
quicklisp.$(1).sbcl-version = $$(call quicklisp.image-variant.sbcl-version,$$(quicklisp.$(1).local-tag))
quicklisp.$(1).remote-tag = $$(call quicklisp.image-variant.remote-tag,$(1),$$(quicklisp.$(1).sbcl-version))

.PHONY : quicklisp.publish.image-variant.$(1)
quicklisp.publish.image-variant.$(1) :
	docker tag $$(quicklisp.$(1).local-tag) $$(quicklisp.$(1).remote-tag) \
	$$(if $(filter-out $(1),$(root.image-variants.default)),,\
		&& docker tag $$(quicklisp.$(1).local-tag) $(quicklisp.repository):latest \
		&& docker push $(quicklisp.repository):latest) \
	&& docker push $$(quicklisp.$(1).remote-tag) \
	&& docker image rm --force $$(quicklisp.$(1).local-tag)
endef

####################################################################################################

$(foreach img,$(root.image-variants),\
	$(eval $(call quicklisp.publish.image-variant__generate,$(img))))
