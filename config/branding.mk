FUSE_STATUS = 2.0

ifndef FUSE_BUILD_TYPE
    FUSE_BUILD_TYPE := Unofficial
endif

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
LIST := $(shell cat vendor/fuse/fuse.devices)

ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
    ifeq ($(filter-out Official OFFICIAL, $(FUSE_BUILD_TYPE)),)
        ifeq ($(FUSE_BUILD_TYPE), Official)
          BUILD_TYPE := Official
        endif
        ifeq ($(FUSE_BUILD_TYPE), OFFICIAL)
          BUILD_TYPE := OFFICIAL
        endif
    endif
else
    ifeq ($(filter-out Official OFFICIAL, $(FUSE_BUILD_TYPE)),)
      $(error "Invalid FUSE_BUILD_TYPE!")
    endif
endif

TARGET_PRODUCT_SHORT := $(subst fuse_,,$(TARGET_PRODUCT))

FUSE_VERSION := FusionOS-v$(FUSE_STATUS)-$(TARGET_PRODUCT_SHORT)-$(shell date -u +%Y%m%d)-$(FUSE_BUILD_TYPE)

FUSE_BRANDING_VERSION := $(FUSE_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.build.project=fuse \
  ro.fuse.version=$(FUSE_VERSION) \
  ro.fuse.status=$(FUSE_STATUS) \
  ro.fuse.branding.version=$(FUSE_BRANDING_VERSION)
