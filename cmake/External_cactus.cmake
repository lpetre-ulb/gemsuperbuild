ExternalProject_Add(cactus-ipbus
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/cactus/ipbus"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/cactus"

  URL "https://github.com/ipbus/ipbus-software/archive/v2.6.3.tar.gz"

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND $(MAKE)
    Set=uhal
    "prefix=<INSTALL_DIR>"
  INSTALL_COMMAND $(MAKE) install
    Set=uhal
    "prefix=<INSTALL_DIR>"
)

ExternalProject_Add(cactus-amc13
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/cactus/amc13"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/cactus"

  #URL "https://svnweb.cern.ch/trac/cactus/browser/tags/amc13/amc13_v1_2_13?rev=50949&format=zip"
  URL "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/amc13_v1_2_13.tar.xz"

  PATCH_COMMAND patch -p1 -i "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/amc13-install.patch"

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND make
    "CACTUS_ROOT=${CMAKE_BINARY_DIR}/install/cactus"
    "INSTALL_PREFIX=<INSTALL_DIR>"
  INSTALL_COMMAND make install
    "CACTUS_ROOT=${CMAKE_BINARY_DIR}/install/cactus"
    "INSTALL_PREFIX=<INSTALL_DIR>"

  DEPENDS cactus-ipbus
)

