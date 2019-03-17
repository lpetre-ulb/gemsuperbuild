include(ExternalProject)

function(superbuild_add_project _project_name)
  # Arguments parsing
  cmake_parse_arguments(_args "" "TARGET;DEPENDENCY_NAME" "" ${ARGN})

  if(_args_TARGET)
    set(SUPERBUILD_TARGET "${_args_TARGET}")
  endif()

  string(TOLOWER "${_project_name}" _project_name)
  string(TOLOWER "${SUPERBUILD_TARGET}" _gem_target)

  # Available variables for the EP
  set(EP_NAME "${_project_name}.${_gem_target}")
  set(EP_PREFIX "${CMAKE_BINARY_DIR}/${EP_NAME}")
  set(EP_DEPENDENCIES "")

  # Return EP_NAME if requested
  if(_args_DEPENDENCY_NAME)
    set("${_args_DEPENDENCY_NAME}" "${EP_NAME}" PARENT_SCOPE)
  endif()

  # Include the project only once
  get_property(included GLOBAL PROPERTY "${EP_NAME}" SET)
  if(NOT included)
    set_property(GLOBAL PROPERTY "${EP_NAME}" TRUE)

    set(_build_prefix_dir "${CMAKE_SOURCE_DIR}/projects/${_project_name}/")

    if(EXISTS "${_build_prefix_dir}/${_gem_target}.superbuild.cmake")
      include("${_build_prefix_dir}/${_gem_target}.superbuild.cmake")
    elseif(EXISTS "${_build_prefix_dir}/superbuild.cmake")
      include("${_build_prefix_dir}/superbuild.cmake")
    else()
      message(FATAL_ERROR "Project ${_project_name} for ${_gem_target} not found !")
    endif()

    message(STATUS "${EP_NAME} added !")
  endif()
endfunction()

function(superbuild_add_dependencies)
  # Add all dependencies
  foreach(_dependency ${ARGN})
    superbuild_add_project("${_dependency}"
      DEPENDENCY_NAME _dependency_targetname)
    if(_dependency_targetname)
      list(APPEND EP_DEPENDENCIES "${_dependency_targetname}")
    endif()
  endforeach()

  set(EP_DEPENDENCIES "${EP_DEPENDENCIES}" PARENT_SCOPE)
  message(STATUS "${EP_NAME} will depend of ${EP_DEPENDENCIES}")
endfunction()

