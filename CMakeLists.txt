cmake_minimum_required(VERSION 3.6 FATAL_ERROR)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Prevent in-source builds
include(PreventInSourceBuilds)

project(gemsuperbuild
  LANGUAGES NONE)

include(SuperbuildCache)
include(SuperbuildProject)

# Installation prefix
if(NOT DEFINED SUPERBUILD_INSTALL_DIR)
  set(SUPERBUILD_INSTALL_DIR "${CMAKE_SOURCE_DIR}/install")
endif()

set(SUPERBUILD_INSTALL_DIR
  "${SUPERBUILD_INSTALL_DIR}" CACHE PATH
  "Path where the software will be installed for the developer.")

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

option(EXPERIMENTAL_BUILD
  "Build experimental projects which could fail the build."
  OFF
)

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

  superbuild_add_project(reg_utils)
  superbuild_add_project(xhal)
  superbuild_add_project(ipbus-sw)
  superbuild_add_project(amc13-sw)

  if(EXPERIMENTAL_BUILD)
    superbuild_add_project(cmsgemos)
  endif()
endif(PC_BUILD)

