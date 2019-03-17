superbuild_add_dependencies(ipbus-sw)

ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  # FIXME : This target still does not use the cache because the zip is corrupted...
  #URL "https://svnweb.cern.ch/trac/cactus/browser/tags/amc13/amc13_v1_2_13?rev=50949&format=zip"
  URL "${CMAKE_SOURCE_DIR}/third_party/amc13_v1_2_13.tar.xz"

  PATCH_COMMAND patch -p1 -i "${CMAKE_CURRENT_LIST_DIR}/amc13-cpp11.patch"
  COMMAND       patch -p1 -i "${CMAKE_CURRENT_LIST_DIR}/amc13-python3.patch"
  COMMAND       patch -p1 -i "${CMAKE_CURRENT_LIST_DIR}/amc13-install.patch"
  COMMAND       patch -p1 -i "${CMAKE_CURRENT_LIST_DIR}/amc13-as-needed.patch"

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND make
    "SHELL=bash"
    "CACTUS_ROOT=<INSTALL_DIR>/opt/cactus"
    "INSTALL_PREFIX=<INSTALL_DIR>/opt/cactus"
  INSTALL_COMMAND make install
    "SHELL=bash"
    "CACTUS_ROOT=<INSTALL_DIR>/opt/cactus"
    "INSTALL_PREFIX=<INSTALL_DIR>/opt/cactus"

  DEPENDS ${EP_DEPENDENCIES}
)

