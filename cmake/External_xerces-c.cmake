ExternalProject_Add(xerces-c
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/xerces-c"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/arm"
  DOWNLOAD_COMMAND URL "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/xerces-c-3.1.4.tar.xz"
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

