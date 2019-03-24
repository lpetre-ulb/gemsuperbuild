superbuild_add_dependencies(pugixml)

ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  DOWNLOAD_DIR "${SUPERBUILD_CACHE_DIR}"
  URL "https://github.com/ipbus/ipbus-software/archive/106b66b79c7bd936c23e6ad0a4a49220b530ec18.tar.gz"
  DOWNLOAD_NAME ipbus-106b66b79c7bd936c23e6ad0a4a49220b530ec18.tar.gz
  URL_HASH SHA256=41d9251976c59fdf35e6d08f5a17b6c4d4ccf40a883fd5957c4758e48b9e6372

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND $(MAKE)
    Set=uhal
    "prefix=<INSTALL_DIR>/opt/cactus"
    "CPATH=<INSTALL_DIR>/usr/include"
    "LIBRARY_PATH=<INSTALL_DIR>/usr/lib"
  INSTALL_COMMAND $(MAKE) install
    Set=uhal
    "prefix=<INSTALL_DIR>/opt/cactus"
    "CPATH=<INSTALL_DIR>/usr/include"
    "LIBRARY_PATH=<INSTALL_DIR>/usr/lib"

  DEPENDS ${EP_DEPENDENCIES}
)

