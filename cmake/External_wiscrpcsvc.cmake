ExternalProject_Add(wiscrpcsvc
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/thirdparty/wiscrpcsvc"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/x86_64"
  URL "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/rpcsvc-master.zip"
  CONFIGURE_COMMAND ""
  BUILD_IN_SOURCE TRUE
  BUILD_COMMAND
    make -C ./libwiscrpcsvc-client build
  INSTALL_COMMAND 
    install ./libwiscrpcsvc-client/libwiscrpcsvc.so "<INSTALL_DIR>/usr/lib"
)

