ExternalProject_Add(xdaq-core
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/xdaq/core"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/xdaq"

  # Use the archive download instead of the Git clone
  # The CMake Git mode has a bug which triggers a build on every 
  # run : https://gitlab.kitware.com/cmake/cmake/issues/16419
  # Because the dependency within xDAQ is complex, most of the
  # sources are then built on every run and we do not want that.
  URL https://gitlab.cern.ch/cmsos/core/-/archive/release_14_10_0_0/core-release_14_10_0_0.tar.bz2

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND make
    "XDAQ_ROOT=<SOURCE_DIR>"
    PROJECT_NAME=core
    "INSTALL_PREFIX=<INSTALL_DIR>"
  INSTALL_COMMAND make install
    "XDAQ_ROOT=<SOURCE_DIR>"
    PROJECT_NAME=core
    "INSTALL_PREFIX=<INSTALL_DIR>"
)

# xDAQ worksuite packages to be build
# Other packages have not been tested and might not compile
set(WORKSUITE_PACKAGES
  "xdaq2rc \
   extern/oracle \
   tstore/utils tstore/client tstore tstore/api"
)

ExternalProject_Add(xdaq-worksuite
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/xdaq/worksuite"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/xdaq"

  # Use the archive download instead of the Git clone
  # The CMake Git mode has a bug which triggers a build on every 
  # run : https://gitlab.kitware.com/cmake/cmake/issues/16419
  # Because the dependency within xDAQ is complex, most of the
  # sources are then built on every run and we do not want that.
  URL https://gitlab.cern.ch/cmsos/worksuite/-/archive/release_14_9_0_0/worksuite-release_14_9_0_0.tar.bz2

  PATCH_COMMAND
    sed "s/BUILD_HOME/XDAQ_ROOT/g" "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/xdaq/core/src/xdaq-core/mfDefs.core" > "<SOURCE_DIR>/mfDefs.core"
    && echo "include <SOURCE_DIR>/mfDefs.core" >> "<SOURCE_DIR>/mfDefs.worksuite"

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND make
    "XDAQ_ROOT=${CMAKE_CURRENT_BINARY_DIR}/thirdparty/xdaq/core/src/xdaq-core"
    PROJECT_NAME=worksuite
    "PACKAGES=${WORKSUITE_PACKAGES}"
    "INSTALL_PREFIX=<INSTALL_DIR>"
  INSTALL_COMMAND make install
    "XDAQ_ROOT=${CMAKE_CURRENT_BINARY_DIR}/thirdparty/xdaq/core/src/xdaq-core"
    PROJECT_NAME=worksuite
    "PACKAGES=${WORKSUITE_PACKAGES}"
    "INSTALL_PREFIX=<INSTALL_DIR>"

  DEPENDS xdaq-core
)
