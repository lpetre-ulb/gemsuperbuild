ExternalProject_Add(log4cplus
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/log4cplus"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/arm"
  DOWNLOAD_COMMAND URL "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/log4cplus-1.1.2.tar.xz"
  CONFIGURE_COMMAND "<SOURCE_DIR>/configure" --prefix=/usr --disable-threads
    --host=arm-linux 
    "--with-sysroot=${PETA_SYSROOT}"
    "CC=arm-linux-gnueabihf-gcc"
    "CXX=arm-linux-gnueabihf-g++"
    "CXXFLAGS=-fomit-frame-pointer -pipe -fno-common -fno-builtin -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mthumb-interwork -mtune=cortex-a9 -DEMBED -Dlinux -D__linux__ -Dunix -fPIC"
    "CFLAGS=-fomit-frame-pointer -pipe -fno-common -fno-builtin -Wall -march=armv7-a -mfpu=neon -mfloat-abi=hard -mthumb-interwork -mtune=cortex-a9 -DEMBED -Dlinux -D__linux__ -Dunix -fPIC"
  BUILD_COMMAND make -j8
  INSTALL_COMMAND make install "DESTDIR=<INSTALL_DIR>"
)

