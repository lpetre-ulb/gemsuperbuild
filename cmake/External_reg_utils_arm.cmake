ExternalProject_Add(reg_utils_arm
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/reg_utils"
  INSTALL_DIR "${CMAKE_BINARY_DIR}/install/arm"
  SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/reg_utils"
  CMAKE_ARGS
    "-DCMAKE_TOOLCHAIN_FILE=<SOURCE_DIR>/cmake/Toolchain_Peta.cmake"
    "-DPETA_SYSROOT=${PETA_SYSROOT}"
    "-DCMAKE_INSTALL_PREFIX=/usr"
  INSTALL_COMMAND make install "DESTDIR=<INSTALL_DIR>"
)

