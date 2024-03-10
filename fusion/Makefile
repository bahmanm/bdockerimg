fusion.root.dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

####################################################################################################

fusion.definitions := sdkman.bmakelib quicklisp.bmakelib

####################################################################################################

.PHONY : fusion.all.build

fusion.all.build : $(fusion.definitions:%=fusion.%.build)

####################################################################################################

.PHONY : fusion.all.publish

fusion.all.publish : $(fusion.definitions:%=fusion.%.publish)

####################################################################################################

# 1: fusion-name
define fusion.build-and-publish__generate

####################

.PHONY : fusion.$(1).build

fusion.$(1).build : $(root.image-variants:%=fusion.$(1).variant.%.build)

####################

.PHONY : fusion.$(1).publish

fusion.$(1).publish : $(root.image-variants:%=fusion.$(1).variant.%.publish)

endef

####################################################################################################

# 1: fusion-name
# 2: image-variant
# 3: fusion-deps
define fusion.variant.build-and-publish__generate

####################

fusion.$(1).$(2).tag := $(call bmakelib.shell.error-if-nonzero,\
				$(fusion.root.dir)fusion.Dockerfile.generate.pl $(fusion.root.dir) $(2) $(3))

####################

.PHONY : fusion.$(1).variant.$(2).build

fusion.$(1).variant.$(2).build : bmakelib.error-if-blank( fusion.$(1).$(2).tag )
fusion.$(1).variant.$(2).build :
	docker build --tag $(root.repository)/$(1):$$(fusion.$(1).$(2).tag) \
		--file $(fusion.root.dir)Dockerfile.$$(fusion.$(1).$(2).tag) $(fusion.root.dir)

####################

.PHONY : fusion.$(1).variant.$(2).publish

fusion.$(1).variant.$(2).publish : bmakelib.error-if-blank( fusion.$(1).$(2).tag )
fusion.$(1).variant.$(2).publish :
	docker push $(root.repository)/$(1):$$(fusion.$(1).$(2).tag) \
	$(if $(filter-out $(2),$(root.image-variants.default)),,\
		&& docker tag \
			$(root.repository)/$(1):$$(fusion.$(1).$(2).tag) \
			$(root.repository)/$(1):latest \
		&& docker push $(root.repository)/$(1):latest) \
	&& docker tag \
		$(root.repository)/$(1):$$(fusion.$(1).$(2).tag) \
		$(root.repository)/$(1):$(2) \
	&& docker push $(root.repository)/$(1):$(2)

endef

####################################################################################################

$(foreach fusion,$(fusion.definitions),\
	$(eval $(call fusion.build-and-publish__generate,$(fusion)))\
	$(let deps,$(subst ., ,$(fusion)),\
		$(foreach variant,$(root.image-variants),\
			$(eval $(call fusion.variant.build-and-publish__generate,$(fusion),$(variant),$(deps))))))
