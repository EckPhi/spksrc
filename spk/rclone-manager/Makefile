SPK_NAME = rclone-manager
SPK_VERS = 0.3.4
SPK_REV = 1
SPK_ICON = src/rclone-manager.png

DEPENDS = cross/rclone-manager cross/rclone

REQUIRED_MIN_DSM = 7.2
MIN_GLIBC_VERSION = 2.34
REQUIRE_64BIT = 1

MAINTAINER = EckPhi
DISPLAY_NAME = RClone Manager
DESCRIPTION = Web interface for managing Rclone remotes, transfers, sync jobs and mounts.
HOMEPAGE = https://github.com/Zarestia-Dev/rclone-manager
HELPURL = https://github.com/Zarestia-Dev/rclone-manager/issues
LICENSE = GPLv3
CHANGELOG = "Initial release of RClone Manager 0.3.4 for DSM 7.2 and later."

STARTABLE = yes
SERVICE_USER = auto
SERVICE_SETUP = src/service-setup.sh
SERVICE_PORT = 8093
ADMIN_PORT = $(SERVICE_PORT)
SERVICE_PORT_TITLE = RClone Manager (HTTP)

WIZARDS_DIR = src/wizard

include ../../mk/spksrc.spk.mk
