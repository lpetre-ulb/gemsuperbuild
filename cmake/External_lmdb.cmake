ExternalProject_Add(lmdb
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/lmdb"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/arm"
  DOWNLOAD_COMMAND URL "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/LMDB_0.9.19.tar.gz"
  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND make -C ./libraries/liblmdb/ -j8
    "CC=arm-linux-gnueabihf-gcc"
    "CFLAGS=-fomit-frame-pointer -pipe -fno-common -fno-builtin -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mthumb-interwork -mtune=cortex-a9 -DEMBED -Dlinux -D__linux__ -Dunix -fPIC --sysroot=${CTP7_SYSROOT} -pthread"
  INSTALL_COMMAND make -C ./libraries/liblmdb install
    "prefix=/usr"
    "DESTDIR=<INSTALL_DIR>"
)

