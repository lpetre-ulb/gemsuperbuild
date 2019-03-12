include(ExternalProject)

function(superbuild_add_project _name)
  string(TOLOWER "${_name}" _name)

  cmake_parse_arguments(_args "" "GEM_TARGET" "" ${ARGN})
  string(TOLOWER "${_args_GEM_TARGET}" _gem_target)

  message(STATUS "${_name} requested for the  ${_gem_target} target.")

  set(EP_NAME "${_name}.${_gem_target}")
  set(EP_PREFIX "${CMAKE_BINARY_DIR}/${EP_NAME}")

  if(EXISTS "${CMAKE_SOURCE_DIR}/projects/${_name}/${_gem_target}.superbuild.cmake")
    include("${CMAKE_SOURCE_DIR}/projects/${_name}/${_gem_target}.superbuild.cmake")
  elseif(EXISTS "${CMAKE_SOURCE_DIR}/projects/${_name}/superbuild.cmake")
    include("${CMAKE_SOURCE_DIR}/projects/${_name}/superbuild.cmake")
  else()
    message(FATAL_ERROR "Project not found !")
  endif()
endfunction()

