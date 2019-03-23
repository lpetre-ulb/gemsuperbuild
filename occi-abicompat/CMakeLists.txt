cmake_minimum_required(VERSION 3.6 FATAL_ERROR)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Prevent in-source builds
include(PreventInSourceBuilds)

# Find OCCI libraries provided by xDAQ
find_package(xDAQ REQUIRED occi)

# Detects the ABI version of the standard library supported by OCCI and sets
# OCCI_SUPPORTED_ABI accordingly.
function(detect_occi_abi)
    # Clear unsupported values
    if(NOT ("${OCCI_SUPPORTED_ABI}" STREQUAL "native" OR
            "${OCCI_SUPPORTED_ABI}" STREQUAL "C++98"))
        unset(OCCI_SUPPORTED_ABI)
    endif()

    if(NOT DEFINED OCCI_SUPPORTED_ABI)
        message(STATUS "Detecting C++ ABI for OCCI")
        # Try with the native ABI
        try_compile(
            compiles
            ${CMAKE_CURRENT_BINARY_DIR}/tmp
            ${CMAKE_CURRENT_SOURCE_DIR}/link-test.cpp
            LINK_LIBRARIES xDAQ::occi)
        if(compiles)
            set(OCCI_SUPPORTED_ABI "native")
            message(STATUS "Detecting C++ ABI for OCCI: ${OCCI_SUPPORTED_ABI}")
        else()
            # Try to force the C++ 98 ABI
            try_compile(
                compiles
                ${CMAKE_CURRENT_BINARY_DIR}
                ${CMAKE_CURRENT_SOURCE_DIR}/link-test.cpp
                COMPILE_DEFINITIONS -D_GLIBCXX_USE_CXX11_ABI=0
                LINK_LIBRARIES xDAQ::occi)
            if(compiles)
                set(OCCI_SUPPORTED_ABI "C++98")
                message(STATUS "Detecting C++ ABI for OCCI: ${OCCI_SUPPORTED_ABI}")
            else()
                set(OCCI_SUPPORTED_ABI "unsupported")
                message(FATAL_ERROR "Could not find a working C++ ABI for OCCI")
            endif()
        endif()
        set(OCCI_SUPPORTED_ABI ${OCCI_SUPPORTED_ABI}
            CACHE INTERNAL "ABI for OCCI (native or C++98)" FORCE)
    endif()
endfunction()

detect_occi_abi()

if(OCCI_SUPPORTED_ABI STREQUAL "C++98")
    # Build the ABI wrapper

    # C++ 98 ABI
    add_library(abi98 OBJECT occi-abicompat.cpp)
    set_property(TARGET abi98 PROPERTY POSITION_INDEPENDENT_CODE TRUE)
    target_compile_definitions(abi98 PRIVATE _GLIBCXX_USE_CXX11_ABI=0)
    target_link_libraries(abi98 xDAQ::occi)

    # Native ABI
    add_library(occi-abicompat SHARED occi-abicompat.cpp)
    target_link_libraries(occi-abicompat PRIVATE abi98)
else()
    # Empty library
    add_library(occi-abicompat SHARED empty.cpp)
endif()

# Install
install(TARGETS occi-abicompat EXPORT OCCICompatConfig LIBRARY)
install(EXPORT OCCICompatConfig DESTINATION share/OCCICompat)

# Test executable
enable_testing()
add_executable(validate EXCLUDE_FROM_ALL link-test.cpp)
target_link_libraries(validate occi-abicompat xDAQ::occi)
add_test(NAME validate
         COMMAND cmake --build . --target validate
         WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
