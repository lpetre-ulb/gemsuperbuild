cmake_minimum_required(VERSION 3.6 FATAL_ERROR)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Prevent in-source builds
include(PreventInSourceBuilds)

project(gemsuperbuild
  LANGUAGES NONE)

include(SuperbuildCache)
include(SuperbuildProject)

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
  superbuild_add_project(log4cplus GEM_TARGET CTP7)
  superbuild_add_project(xerces-c GEM_TARGET CTP7)
  superbuild_add_project(lmdb GEM_TARGET CTP7)

  # Build the software
  superbuild_add_project(reg_utils GEM_TARGET CTP7)
endif(CTP7_BUILD)

if(GLIB_BUILD)
endif(GLIB_BUILD)

if(PC_BUILD)
  option(BUILD_XDAQ 
    "Build XDAQ from sources."
  OFF)

  if(BUILD_XDAQ)
    superbuild_add_project(xdaq GEM_TARGET PC)
  endif()

  superbuild_add_project(wiscrpcsvc-client GEM_TARGET PC)
  superbuild_add_project(reg_utils GEM_TARGET PC)
  superbuild_add_project(xhal GEM_TARGET PC)
  superbuild_add_project(ipbus-sw GEM_TARGET PC)
  superbuild_add_project(amc13-sw GEM_TARGET PC)
endif(PC_BUILD)

