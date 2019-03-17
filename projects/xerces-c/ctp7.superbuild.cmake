ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  DOWNLOAD_DIR "${GEM_SUPERBUILD_CACHE_DIR}"
  URL "http://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.4.tar.xz"
  URL_HASH SHA256=9973cc79481803f8b6652c52faf5195d963f50d209d4f681ec97e2aa014b6241

  CONFIGURE_COMMAND "<SOURCE_DIR>/configure" --prefix=/usr
    --host=arm-linux 
    "--with-sysroot=${CTP7_SYSROOT}"
    "CC=arm-linux-gnueabihf-gcc"
    "CXX=arm-linux-gnueabihf-g++"
    "CXXFLAGS=-fomit-frame-pointer -pipe -fno-common -fno-builtin -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mthumb-interwork -mtune=cortex-a9 -DEMBED -Dlinux -D__linux__ -Dunix -fPIC"
    "CFLAGS=-fomit-frame-pointer -pipe -fno-common -fno-builtin -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mthumb-interwork -mtune=cortex-a9 -DEMBED -Dlinux -D__linux__ -Dunix -fPIC"
  BUILD_COMMAND $(MAKE)
  INSTALL_COMMAND $(MAKE) install "DESTDIR=<INSTALL_DIR>"
)

