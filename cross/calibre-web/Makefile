PKG_NAME = calibre-web
PKG_VERS = 0.6.16
PKG_EXT = tar.gz
PKG_DIST_NAME = v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/janeczku/$(PKG_NAME)/releases/download/${SPK_VERS}
PKG_DIST_FILE = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)
EXTRACT_PATH = $(WORK_DIR)/$(PKG_DIR)

INSTALL_TARGET = calibre-web_custom_install

HOMEPAGE = https://github.com/janeczku/calibre-web
LICENSE = GPLv3

include ../../mk/spksrc.install-resources.mk

.PHONY: calibre-web_custom_install
calibre-web_custom_install: 
	mkdir -p $(STAGING_INSTALL_PREFIX)/share/$(PKG_NAME)
	tar -cf - -C $(EXTRACT_PATH) . | tar -xf - -C $(STAGING_INSTALL_PREFIX)/share/$(PKG_NAME)
