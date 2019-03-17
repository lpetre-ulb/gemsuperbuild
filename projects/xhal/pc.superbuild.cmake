superbuild_add_dependencies(wiscrpcsvc-client xdaq)

ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  SOURCE_DIR "${CMAKE_SOURCE_DIR}/xhal"
  BUILD_ALWAYS TRUE

  CMAKE_ARGS
    "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>/usr"
    "-DCMAKE_FIND_ROOT_PATH=<INSTALL_DIR>"
    "-DCMAKE_PREFIX_PATH=/opt/xdaq/${XDAQ_PLATFORM}"
  INSTALL_COMMAND make install

  DEPENDS ${EP_DEPENDENCIES}
)

