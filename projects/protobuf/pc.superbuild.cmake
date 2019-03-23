ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  DOWNLOAD_DIR "${SUPERBUILD_CACHE_DIR}"
  URL https://github.com/protocolbuffers/protobuf/releases/download/v3.7.0/protobuf-cpp-3.7.0.tar.gz
  URL_HASH SHA256=797e759e6daf644be4c09070d4777d178b538dca310cc4956fde4b51b02ba2d3

  SOURCE_SUBDIR
    "cmake"
  CMAKE_ARGS
    "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>/usr"
    -DBUILD_SHARED_LIBS=ON
    -DCMAKE_INSTALL_LIBDIR=lib
    # FIXME: build tests only when asked by the user
    #-Dprotobuf_BUILD_TESTS=OFF
)

