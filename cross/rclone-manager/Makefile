PKG_NAME = rclone-manager
PKG_VERS = 0.3.4
PKG_EXT = zip
PKG_DIST_NAME = server-linux-$(PKG_DIST_ARCH)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/Zarestia-Dev/rclone-manager/releases/download/headless-v$(PKG_VERS)
PKG_DIR = rclone-manager-server

DEPENDS = cross/dbus

REQUIRED_MIN_DSM = 7.2
MIN_GLIBC_VERSION = 2.34
REQUIRE_64BIT = 1

HOMEPAGE = https://github.com/Zarestia-Dev/rclone-manager
COMMENT = Web interface for managing Rclone remotes and transfers.
LICENSE = GPLv3

PKG_DIST_ARCH_LIST = x86_64 aarch64
INSTALL_TARGET = rclone-manager_install

include ../../mk/spksrc.common.mk
ifneq ($(filter $(ARCH),$(x64_ARCHS)),)
PKG_DIST_ARCH = x86_64
else ifneq ($(filter $(ARCH),$(ARMv8_ARCHS)),)
PKG_DIST_ARCH = aarch64
endif

include ../../mk/spksrc.cross-install.mk

.PHONY: rclone-manager_install
rclone-manager_install:
	@install -d -m 755 $(STAGING_INSTALL_PREFIX)/bin
	@install -m 755 $(WORK_DIR)/$(PKG_DIR)/rclone-manager-server $(STAGING_INSTALL_PREFIX)/bin/
