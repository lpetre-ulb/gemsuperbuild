ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/arm"

  DOWNLOAD_DIR "${GEM_SUPERBUILD_CACHE_DIR}"
  URL "https://github.com/LMDB/lmdb/archive/LMDB_0.9.19.tar.gz"
  URL_HASH SHA256=108532fb94c6f227558d45be3f3347b52539f0f58290a7bb31ec06c462d05326

  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND make -C ./libraries/liblmdb/ -j8
    "CC=arm-linux-gnueabihf-gcc"
    "AR=arm-linux-gnueabihf-ar"
    "CFLAGS=-fomit-frame-pointer -pipe -fno-common -fno-builtin -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mthumb-interwork -mtune=cortex-a9 -DEMBED -Dlinux -D__linux__ -Dunix -fPIC --sysroot=${CTP7_SYSROOT} -pthread"
  INSTALL_COMMAND make -C ./libraries/liblmdb install
    "prefix=/usr"
    "DESTDIR=<INSTALL_DIR>"
)

