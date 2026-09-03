include $(TOPDIR)/rules.mk

PKG_NAME:=higoros
PKG_VERSION:=1.26.04.29.09
PKG_RELEASE:=1
PKG_LICENSE:=Proprietary
PKG_MAINTAINER:=Local H5000M migration

include $(INCLUDE_DIR)/package.mk

define Package/higoros
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=HigoROS web interface and backend
  DEPENDS:=@TARGET_mediatek_filogic @aarch64 +libc +uci +ubus
endef

define Package/higoros/description
  Vendor HigoROS frontend and statically linked backend retained for migration
  testing on the Hiveton H5000M.
endef

define Build/Compile
endef

define Package/higoros/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/higoros $(1)/etc/init.d/higoros
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/96-h5000m-qmodem-redial $(1)/etc/uci-defaults/96-h5000m-qmodem-redial
	$(INSTALL_BIN) ./files/etc/uci-defaults/97-h5000m-wireless $(1)/etc/uci-defaults/97-h5000m-wireless
	$(INSTALL_BIN) ./files/etc/uci-defaults/98-h5000m-network $(1)/etc/uci-defaults/98-h5000m-network
	$(INSTALL_BIN) ./files/etc/uci-defaults/99-h5000m-qmodem $(1)/etc/uci-defaults/99-h5000m-qmodem
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/usr/bin/higorosd $(1)/usr/bin/higorosd
	$(INSTALL_DIR) $(1)/usr/share/higoros
	$(CP) ./files/usr/share/higoros/. $(1)/usr/share/higoros/
	$(INSTALL_DIR) $(1)/www/higoros
	$(CP) ./files/www/higoros/. $(1)/www/higoros/
endef

$(eval $(call BuildPackage,higoros))
