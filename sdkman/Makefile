sdkman.root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

sdkman.image-name := sdkman
sdkman.repository := $(root.repository)/$(sdkman.image-name)

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

sdkman.test : $(root.image-variants:%=sdkman.test.image-variant.%)

####################################################################################################

sdkman.test.image-variant.% :
	$(sdkman.root.dir)test-suite $(call sdkman.image-variant.local-tag,$(*))

####################################################################################################

.PHONY : sdkman.build

sdkman.build : $(root.image-variants:%=sdkman.build.image-variant.%)

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
sdkman.publish : $(root.image-variants:%=sdkman.publish.image-variant.%)

####################################################################################################

# 1: image-variant
define sdkman.publish.image-variant__generate
sdkman.$(1).local-tag = $$(call sdkman.image-variant.local-tag,$(1))
sdkman.$(1).remote-tag = $$(call sdkman.image-variant.remote-tag,$(1))

.PHONY : sdkman.publish.image-variant.$(1)
sdkman.publish.image-variant.$(1) :
	docker tag $$(sdkman.$(1).local-tag) $$(sdkman.$(1).remote-tag) \
	$$(if $(filter-out $(1),$(root.image-variants.default)),,\
		&& docker tag $$(sdkman.$(1).local-tag) $(sdkman.repository):latest \
		&& docker push $(sdkman.repository):latest) \
	&& docker push $$(sdkman.$(1).remote-tag) \
	&& docker image rm --force $$(sdkman.$(1).local-tag)
endef

####################################################################################################

$(foreach img,$(root.image-variants),\
	$(eval $(call sdkman.publish.image-variant__generate,$(img))))
