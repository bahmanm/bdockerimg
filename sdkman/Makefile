sdkman.root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

sdkman.image-name := sdkman
sdkman.repository := $(root.repository)/$(sdkman.image-name)
sdkman.image-variants := ubuntu-2204 opensuse-tumbleweed
sdkman.image-variants.default := ubuntu-2204

####################################################################################################

# 1: image-variant
define sdkman.image-variant.local-tag
$(sdkman.repository):$(1)
endef

####################################################################################################

# 1: image-variant
define sdkman.image-variant.remote-tag
$(sdkman.repository):$(1)
endef

####################################################################################################

.PHONY : sdkman.test

sdkman.test : $(sdkman.image-variants:%=sdkman.test.image-variant.%)

####################################################################################################

sdkman.test.image-variant.% :
	$(sdkman.root.dir)test-suite $(call sdkman.image-variant.local-tag,$(*))

####################################################################################################

.PHONY : sdkman.build

sdkman.build : $(sdkman.image-variants:%=sdkman.build.image-variant.%)

####################################################################################################

# 1: image-variant
define sdkman.build.image-variant
docker build \
	--tag $(call sdkman.image-variant.local-tag,$(1)) \
	--file $(sdkman.root.dir)Dockerfile.$(1) \
	$(sdkman.root.dir)
endef

####################################################################################################

sdkman.build.image-variant.% :
	$(call sdkman.build.image-variant,$(*))

####################################################################################################

.PHONY : sdkman.publish

sdkman.publish : bmakelib.default-if-blank( sdkman.tag,latest )
sdkman.publish : $(sdkman.image-variants:%=sdkman.publish.image-variant.%)

####################################################################################################

# 1: image-variant
define sdkman.publish.image-variant__generate
sdkman.$(1).local-tag = $$(call sdkman.image-variant.local-tag,$(1))
sdkman.$(1).remote-tag = $$(call sdkman.image-variant.remote-tag,$(1))

.PHONY : sdkman.publish.image-variant.$(1)
sdkman.publish.image-variant.$(1) :
	docker tag $$(sdkman.$(1).local-tag) $$(sdkman.$(1).remote-tag) \
	$$(if $(filter-out $(1),$(sdkman.image-variants.default)),,\
		&& docker tag $$(sdkman.$(1).local-tag) $(sdkman.repository):latest \
		&& docker push $(sdkman.repository):latest) \
	&& docker push $$(sdkman.$(1).remote-tag)
endef

####################################################################################################

$(foreach img,$(sdkman.image-variants),\
	$(eval $(call sdkman.publish.image-variant__generate,$(img))))
