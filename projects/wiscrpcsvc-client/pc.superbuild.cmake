ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  DOWNLOAD_DIR "${SUPERBUILD_CACHE_DIR}"
  URL "https://github.com/cms-gem-daq-project/rpcsvc/archive/f75364532253c93dbadece18b8be0fac7140236d.zip"
  DOWNLOAD_NAME rpcsvc-f75364532253c93dbadece18b8be0fac7140236d.zip
  URL_HASH SHA256=50b2762bbe464d2f6e72a2151bc2cee1be983f130f9e5697a2569868402b52e0

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND
    make -C ./libwiscrpcsvc-client build
  INSTALL_COMMAND 
    install -D ./libwiscrpcsvc-client/libwiscrpcsvc.so "<INSTALL_DIR>/usr/lib/libwiscrpcsvc.so"
)

