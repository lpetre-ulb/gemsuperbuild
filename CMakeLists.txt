cmake_minimum_required(VERSION 3.6 FATAL_ERROR)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Prevent in-source builds
include(PreventInSourceBuilds)

project(gemsuperbuild
  LANGUAGES NONE)

# This project is a superbuild...
include(ExternalProject)

# Provide the cache
include(GEMSuperbuildCache)

# GEM targets
option(CTP7_BUILD "\
Build the software running on the CTP7 (ARM architecture). \
It requires the Xilinx SDK and the CTP7 Linux image sysroot. \
" ON
)

option(GLIB_BUILD
  "Build the sofware running on the GLIB."
  OFF
)

option(PC_BUILD
  "Build the software running on the DAQ machine (amd64 architecture)."
  ON
)

# xDAQ environment variables
string(TOLOWER "${CMAKE_SYSTEM_NAME}" XDAQ_OS)
string(TOLOWER "${CMAKE_SYSTEM_PROCESSOR}" XDAQ_PLATFORM)

if(CTP7_BUILD)
  # Minimal check for the Xilinx SDK
  find_program(Xilinx-SDK
    arm-linux-gnueabihf-gcc
  )

  if(NOT Xilinx-SDK)
    message(FATAL_ERROR "The Xilinx SDK was not found. Please check if it is enabled.")
  endif()

  # Ensure that the Peta sysroot path exist
  if(NOT EXISTS "${CTP7_SYSROOT}")
    message(FATAL_ERROR "Please define the CTP7_SYSROOT variable.")
  endif()

  # Build the libraries
  include(External_log4cplus)
  include(External_xerces-c)
  include(External_lmdb)

  # Build the software
  include(External_reg_utils_arm)
endif(CTP7_BUILD)

if(GLIB_BUILD)
endif(GLIB_BUILD)

if(PC_BUILD)
  option(BUILD_XDAQ 
    "Build XDAQ from sources."
  OFF)

  if(BUILD_XDAQ)
    include(External_xdaq)
  endif()

  include(External_wiscrpcsvc)
  include(External_reg_utils_x86_64)
  include(External_xhal_x86_64)
  include(External_cactus)
endif(PC_BUILD)

