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
  set(SUPERBUILD_TARGET CTP7)
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
  superbuild_add_project(log4cplus)
  superbuild_add_project(xerces-c)
  superbuild_add_project(lmdb)

  # Build the software
  superbuild_add_project(reg_utils)
endif(CTP7_BUILD)

if(GLIB_BUILD)
  set(SUPERBUILD_TARGET GLIB)
endif(GLIB_BUILD)

if(PC_BUILD)
  set(SUPERBUILD_TARGET PC)

  option(BUILD_XDAQ 
    "Build XDAQ from sources."
  OFF)

  if(BUILD_XDAQ)
    superbuild_add_project(xdaq)
  endif()

  superbuild_add_project(reg_utils)
  superbuild_add_project(xhal)
  superbuild_add_project(ipbus-sw)
  superbuild_add_project(amc13-sw)
endif(PC_BUILD)

