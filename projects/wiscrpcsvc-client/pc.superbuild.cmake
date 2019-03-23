superbuild_add_dependencies(protobuf)

ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  DOWNLOAD_DIR "${SUPERBUILD_CACHE_DIR}"
  URL "https://github.com/cms-gem-daq-project/rpcsvc/archive/f75364532253c93dbadece18b8be0fac7140236d.zip"
  DOWNLOAD_NAME rpcsvc-f75364532253c93dbadece18b8be0fac7140236d.zip
  URL_HASH SHA256=50b2762bbe464d2f6e72a2151bc2cee1be983f130f9e5697a2569868402b52e0

  PATCH_COMMAND patch -p1 -i "${CMAKE_CURRENT_LIST_DIR}/cmake_build.patch"

  SOURCE_SUBDIR
    "libwiscrpcsvc-client"
  CMAKE_ARGS
    "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>/usr"
    "-DCMAKE_FIND_ROOT_PATH=<INSTALL_DIR>"
    -DBUILD_SHARED_LIBS=ON
    -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=TRUE

  DEPENDS ${EP_DEPENDENCIES}
)

