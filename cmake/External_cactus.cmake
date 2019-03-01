ExternalProject_Add(cactus-ipbus
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/cactus/ipbus"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/cactus"

  URL "https://github.com/ipbus/ipbus-software/archive/v2.6.3.tar.gz"

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND make
    Set=uhal
    "prefix=<INSTALL_DIR>"
  INSTALL_COMMAND make install
    Set=uhal
    "prefix=<INSTALL_DIR>"
)

