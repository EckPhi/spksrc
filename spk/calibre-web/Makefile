SPK_NAME = calibre-web
SPK_VERS = 0.6.16
SPK_REV = 1
SPK_ICON = src/$(SPK_NAME).png

BUILD_DEPENDS = cross/python310

#DEPENDS = cross/$(SPK_NAME)

SPK_DEPENDS = "python310"

MAINTAINER = SynoCommunity

DESCRIPTION = Calibre-Web is a web app for browsing, reading and downloading eBooks stored in a Calibre database.
DISPLAY_NAME = Calibre-Web
STARTABLE = yes
CHANGELOG = "Initial release"

HOMEPAGE = https://github.com/janeczku/calibre-web
LICENSE = GPLv3

SERVICE_USER  = auto
SERVICE_SETUP = src/service-setup.sh

SERVICE_PORT  = 8083
SERVICE_PORT_TITLE = $(DISPLAY_NAME)

# Admin link for in DSM UI
ADMIN_PORT = $(SERVICE_PORT)

WHEELS = src/requirements-crossenv.txt src/requirements-pure.txt

# [numpy] gcc-4.6.4 failed with exit status 1
# https://github.com/numpy/numpy/issues/20664
#UNSUPPORTED_ARCHS = $(ARMv5_ARCHS)

include ../../mk/spksrc.common.mk

include ../../mk/spksrc.spk.mk
