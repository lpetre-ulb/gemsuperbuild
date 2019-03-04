ExternalProject_Add(xhal_x86_64
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/xhal"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/x86_64"
  SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/xhal"
  BUILD_ALWAYS TRUE
  CMAKE_ARGS
    "-DCMAKE_INSTALL_PREFIX=/usr"
    "-DCMAKE_PREFIX_PATH=${CMAKE_CURRENT_BINARY_DIR}/install/xdaq/${XDAQ_PLATFORM}"
    "-DCMAKE_FIND_ROOT_PATH=${CMAKE_CURRENT_BINARY_DIR}/install/x86_64"
  INSTALL_COMMAND make install "DESTDIR=<INSTALL_DIR>"

  DEPENDS wiscrpcsvc xdaq-core
)

