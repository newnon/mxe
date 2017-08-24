# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libwebsockets
$(PKG)_WEBSITE  := https://libwebsockets.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.3.0
$(PKG)_CHECKSUM := f08a8233ca1837640b72b1790cce741ce4b0feaaa6b408fe28a303cbf0408fa1
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/warmcat/libwebsockets/archive/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := gcc openssl zlib

define $(PKG)_UPDATE
    $(call MXE_GET_GITHUB_TAGS, warmcat/libwebsockets, \(v\|.[^0-9].*\))
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(TARGET)-cmake' \
        -DLWS_WITHOUT_TESTAPPS=ON \
        -DLWS_USE_EXTERNAL_ZLIB=ON
    $(MAKE) -C '$(1)' -j $(JOBS)
    $(MAKE) -C '$(1)' install
endef
