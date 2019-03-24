superbuild_add_dependencies(wiscrpcsvc-client)

ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  SOURCE_DIR "${CMAKE_SOURCE_DIR}/reg_utils"
  BUILD_ALWAYS TRUE

  CMAKE_ARGS
    "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>/usr"
    "-DCMAKE_FIND_ROOT_PATH=<INSTALL_DIR>"

  DEPENDS ${EP_DEPENDENCIES}
)

