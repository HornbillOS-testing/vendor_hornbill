GET_VERSION := vendor/fuse/build/tools/getversion.py
FUSE_STATUS := $(shell $(GET_VERSION) status)
BUILD_TYPE := $(shell $(GET_VERSION) buildtype)
FUSE_BRANDING_VERSION := $(BUILD_TYPE)
FUSE_VERSION := $(shell $(GET_VERSION) version)

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif
