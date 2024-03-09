bmakelib.root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

bmakelib.image-name := bmakelib
bmakelib.repository := $(root.repository)/$(bmakelib.image-name)
bmakelib.version := 0.7.0
bmakelib.tarball := https://github.com/bahmanm/bmakelib/releases/download/v$(bmakelib.version)/bmakelib-$(bmakelib.version).tar.gz

####################################################################################################

# 1: image-variant
define bmakelib.image-variant.local-tag
$(bmakelib.repository):$(1)
endef

####################################################################################################

# 1: image-variant
define bmakelib.image-variant.remote-tag
$(bmakelib.repository):$(bmakelib.version)--$(1)
endef

####################################################################################################

.PHONY : bmakelib.test

bmakelib.test : $(root.image-variants:%=bmakelib.test.image-variant.%)

####################################################################################################

bmakelib.test.image-variant.% :
	$(bmakelib.root.dir)test-suite $(call bmakelib.image-variant.local-tag,$(*))

####################################################################################################

.PHONY : bmakelib.build

bmakelib.build : $(root.image-variants:%=bmakelib.build.image-variant.%)

####################################################################################################

# 1: image-variant
define bmakelib.build.image-variant
docker build \
	--tag $(call bmakelib.image-variant.local-tag,$(1)) \
	--file $(bmakelib.root.dir)Dockerfile.$(1) \
	$(bmakelib.root.dir)
endef

####################################################################################################

bmakelib.build.image-variant.% :
	$(call bmakelib.build.image-variant,$(*))

####################################################################################################

.PHONY : bmakelib.publish

bmakelib.publish : bmakelib.default-if-blank( bmakelib.tag,latest )
bmakelib.publish : $(root.image-variants:%=bmakelib.publish.image-variant.%)

####################################################################################################

# 1: image-variant
define bmakelib.publish.image-variant__generate
bmakelib.$(1).local-tag = $$(call bmakelib.image-variant.local-tag,$(1))
bmakelib.$(1).remote-tag = $$(call bmakelib.image-variant.remote-tag,$(1))

.PHONY : bmakelib.publish.image-variant.$(1)
bmakelib.publish.image-variant.$(1) :
	docker tag $$(bmakelib.$(1).local-tag) $$(bmakelib.$(1).remote-tag) \
	$$(if $(filter-out $(1),$(root.image-variants.default)),,\
		&& docker tag $$(bmakelib.$(1).local-tag) $(bmakelib.repository):latest \
		&& docker push $(bmakelib.repository):latest) \
	&& docker push $$(bmakelib.$(1).remote-tag)
endef

####################################################################################################

$(foreach img,$(root.image-variants),\
	$(eval $(call bmakelib.publish.image-variant__generate,$(img))))
