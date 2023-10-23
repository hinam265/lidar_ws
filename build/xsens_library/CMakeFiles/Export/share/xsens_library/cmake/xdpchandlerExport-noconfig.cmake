#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "xsens_library::xdpchandler" for configuration ""
set_property(TARGET xsens_library::xdpchandler APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(xsens_library::xdpchandler PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libxdpchandler.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS xsens_library::xdpchandler )
list(APPEND _IMPORT_CHECK_FILES_FOR_xsens_library::xdpchandler "${_IMPORT_PREFIX}/lib/libxdpchandler.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
