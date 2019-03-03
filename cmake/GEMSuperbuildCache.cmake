# This module defines the cache path variable and populates it with
# archives found in ${CMAKE_SOURCE_DIR}/thirdparty

function(gem_set_cache_dir)
  if(NOT DEFINED GEM_SUPERBUILD_CACHE_DIR)
    set(GEM_SUPERBUILD_CACHE_DIR "${CMAKE_BINARY_DIR}/cache")
  endif()
  
  set(GEM_SUPERBUILD_CACHE_DIR
    "${GEM_SUPERBUILD_CACHE_DIR}" CACHE PATH
    "Path where the cached archives will be stored. 
Define this path to a location outside of your build directory to avoid re-downloading archives.")
endfunction()

function(gem_populate_cache)
  file(GLOB ARCHIVE_FILES
    "${CMAKE_SOURCE_DIR}/thirdparty/*.tar*"
    "${CMAKE_SOURCE_DIR}/thirdparty/*.zip"
  )
  
  foreach(ARCHIVE_FILE ${ARCHIVE_FILES})
    get_filename_component(ARCHIVE_FILENAME "${ARCHIVE_FILE}" NAME)

    if(NOT EXISTS "${GEM_SUPERBUILD_CACHE_DIR}/${ARCHIVE_FILENAME}")
      message("Copying ${ARCHIVE_FILENAME} to the cache.")

      file(COPY "${ARCHIVE_FILE}"
        DESTINATION "${GEM_SUPERBUILD_CACHE_DIR}")
    endif()

  endforeach()
endfunction()

gem_set_cache_dir()
gem_populate_cache()

