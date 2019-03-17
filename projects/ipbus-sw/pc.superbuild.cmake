ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  DOWNLOAD_DIR "${SUPERBUILD_CACHE_DIR}"
  URL "https://github.com/ipbus/ipbus-software/archive/v2.6.3.tar.gz"
  DOWNLOAD_NAME ipbus-v2.6.3.tar.gz
  URL_HASH SHA256=09fd5359cd9f750dd90495d6603f6609ef8ee34704c029f1dafcc54e15bf2b79

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND $(MAKE)
    Set=uhal
    "prefix=<INSTALL_DIR>/opt/cactus"
  INSTALL_COMMAND $(MAKE) install
    Set=uhal
    "prefix=<INSTALL_DIR>/opt/cactus"
)

