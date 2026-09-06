include $(TOPDIR)/rules.mk

PKG_NAME:=fancontrol
PKG_VERSION:=2.0
PKG_RELEASE:=2
PKG_LICENSE:=GPL-2.0-only
PKG_MAINTAINER:=H5000M project

include $(INCLUDE_DIR)/package.mk

define Package/fancontrol
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=H5000M PWM fan controller
  DEPENDS:=@TARGET_mediatek_filogic +uci +kmod-hwmon-pwmfan
endef

define Package/fancontrol/description
  Conservative PROJECT_LOCAL temperature-to-PWM policy for Hiveton H5000M.
endef

define Build/Compile
endef

define Package/fancontrol/install
	$(INSTALL_DIR) $(1)/etc/init.d $(1)/etc/config $(1)/usr/bin
	$(INSTALL_BIN) ./files/etc/init.d/fancontrol $(1)/etc/init.d/fancontrol
	$(INSTALL_CONF) ./files/etc/config/fancontrol $(1)/etc/config/fancontrol
	$(INSTALL_BIN) ./files/usr/bin/fancontrol $(1)/usr/bin/fancontrol
endef

$(eval $(call BuildPackage,fancontrol))
