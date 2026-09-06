include $(TOPDIR)/rules.mk

PKG_NAME:=h5000m-full-compat
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0-only
PKG_MAINTAINER:=H5000M project

include $(INCLUDE_DIR)/package.mk

define Package/h5000m-full-compat
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=H5000M Full vendor compatibility contracts
  DEPENDS:=@TARGET_mediatek_filogic +appfilter +wrtbwmon +uci
endef

define Package/h5000m-full-compat/description
  Narrow PROJECT_LOCAL compatibility files for source-built current Full services.
endef

define Build/Compile
endef

define Package/h5000m-full-compat/install
	$(INSTALL_DIR) $(1)/etc/config $(1)/usr/bin
	$(INSTALL_CONF) ./files/etc/config/appfilter $(1)/etc/config/appfilter
	$(INSTALL_BIN) ./files/usr/bin/oaf_rule $(1)/usr/bin/oaf_rule
endef

$(eval $(call BuildPackage,h5000m-full-compat))
