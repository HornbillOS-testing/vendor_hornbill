HORNBILL_STATUS = 2.0

ifndef HORNBILL_BUILD_TYPE
    HORNBILL_BUILD_TYPE := Unofficial
endif

ifneq ($(SIGNING_KEYS),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := $(SIGNING_KEYS)/releasekey
endif

CURRENT_DEVICE := $(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
LIST := $(shell cat vendor/hornbill/hornbill.devices)

ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
    ifeq ($(filter-out BETA OFFICIAL, $(HORNBILL_BUILD_TYPE)),)
        ifeq ($(HORNBILL_BUILD_TYPE), BETA)
          BUILD_TYPE := BETA
        endif
        ifeq ($(HORNBILL_BUILD_TYPE), OFFICIAL)
          BUILD_TYPE := OFFICIAL
        endif
    endif
else
    ifeq ($(filter-out BETA OFFICIAL, $(HORNBILL_BUILD_TYPE)),)
      $(error "Invalid HORNBILL_BUILD_TYPE!")
    endif
endif

TARGET_PRODUCT_SHORT := $(subst hornbill_,,$(TARGET_PRODUCT))

HORNBILL_VERSION := hornbill-v$(HORNBILL_STATUS)-$(TARGET_PRODUCT_SHORT)-$(shell date -u +%Y%m%d)-$(HORNBILL_BUILD_TYPE)

HORNBILL_BRANDING_VERSION := $(HORNBILL_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.build.project=hornbill \
  ro.hornbill.version=$(HORNBILL_VERSION) \
  ro.hornbill.status=$(HORNBILL_STATUS) \
  ro.hornbill.branding.version=$(HORNBILL_BRANDING_VERSION)
