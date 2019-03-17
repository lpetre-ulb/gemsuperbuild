ExternalProject_Add(${EP_NAME}
  PREFIX "${EP_PREFIX}"
  INSTALL_DIR "${EP_INSTALL_DIR}"

  DOWNLOAD_DIR "${GEM_SUPERBUILD_CACHE_DIR}"
  URL "https://netix.dl.sourceforge.net/project/log4cplus/log4cplus-stable/1.1.2/log4cplus-1.1.2.tar.xz"
  URL_HASH SHA256=999427580cded403b4edc8a85088621f27493c489f08b9f564fb5fe76c16a883

  CONFIGURE_COMMAND "<SOURCE_DIR>/configure" --prefix=/usr --disable-threads
    --host=arm-linux 
    "--with-sysroot=${CTP7_SYSROOT}"
    "CC=arm-linux-gnueabihf-gcc"
    "CXX=arm-linux-gnueabihf-g++"
    "CXXFLAGS=-fomit-frame-pointer -pipe -fno-common -fno-builtin -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mthumb-interwork -mtune=cortex-a9 -DEMBED -Dlinux -D__linux__ -Dunix -fPIC"
    "CFLAGS=-fomit-frame-pointer -pipe -fno-common -fno-builtin -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mthumb-interwork -mtune=cortex-a9 -DEMBED -Dlinux -D__linux__ -Dunix -fPIC"
  BUILD_COMMAND $(MAKE)
  INSTALL_COMMAND $(MAKE) install "DESTDIR=<INSTALL_DIR>"
)

