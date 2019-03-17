# This module defines the cache path variable and populates it with
# archives found in the ${CMAKE_SOURCE_DIR}/third_party directory

function(_superbuild_set_cache_dir)
  if(NOT DEFINED SUPERBUILD_CACHE_DIR)
    set(SUPERBUILD_CACHE_DIR "${CMAKE_BINARY_DIR}/cache")
  endif()
  
  set(SUPERBUILD_CACHE_DIR
    "${SUPERBUILD_CACHE_DIR}" CACHE PATH
    "Path where the cached archives will be stored. 
Define this path to a location outside of your build directory to avoid re-downloading archives.")
endfunction()

function(_superbuild_populate_cache)
  file(GLOB ARCHIVE_FILES
    "${CMAKE_SOURCE_DIR}/third_party/*.tar*"
    "${CMAKE_SOURCE_DIR}/third_party/*.zip"
  )
  
  foreach(ARCHIVE_FILE ${ARCHIVE_FILES})
    get_filename_component(ARCHIVE_FILENAME "${ARCHIVE_FILE}" NAME)

    if(NOT EXISTS "${SUPERBUILD_CACHE_DIR}/${ARCHIVE_FILENAME}")
      message("Copying ${ARCHIVE_FILENAME} to the cache.")

      file(COPY "${ARCHIVE_FILE}"
        DESTINATION "${SUPERBUILD_CACHE_DIR}")
    endif()

  endforeach()
endfunction()

_superbuild_set_cache_dir()
_superbuild_populate_cache()

