cmake_minimum_required(VERSION 2.8.12 FATAL_ERROR)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Prevent in-source builds
include(PreventInSourceBuilds)

project(gemsuperbuild)

# This project is a superbuild...
include(ExternalProject)

option(ARM_BUILD
  "Build the software running on the ARM architecture (CTP7). \
   It requires the Xilinx SDK and the Peta Linux image sysroot"
  ON)

option(X86_64_BUILD
  "Build the software running on the x86_64 architecture (main DAQ software)."
  ON)

if(ARM_BUILD)
  # Minimal check for the Xilinx SDK
  find_program(Xilinx-SDK
    arm-linux-gnueabihf-gcc
  )

  if(NOT Xilinx-SDK)
    message(FATAL_ERROR "The Xilinx SDK was not found. Please check if it is enabled.")
  endif()

  # Ensure that the Peta sysroot path exist
  if(NOT EXISTS "${PETA_SYSROOT}")
    message(FATAL_ERROR "Please define the PETA_SYSROOT variable.")
  endif()

  # Build the libraries
  include(External_log4cplus)
endif(ARM_BUILD)

