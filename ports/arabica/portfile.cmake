include(vcpkg_common_functions)

if(VCPKG_TARGET_IS_WINDOWS)
  vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO BenKeyFSI/arabica
  REF 2020-February
  SHA512 3cf56a71c53e35eb2bc48332c96958e6800e5735a629f292f47e9b22b106f378e45abe046d6a7ed8604fe434d356efbf8744bd31fa905de6fcec62c7223f9e4c
  HEAD_REF master
)

set(ARABICA_ROOT ${SOURCE_PATH})
set(ARABICA_INCLUDE_PATH ${ARABICA_ROOT}/include)

if(VCPKG_TARGET_IS_WINDOWS)

  set(ARABICA_PROJECTS_PATH ${ARABICA_ROOT}/vs2013+)

  if(TRIPLET_SYSTEM_ARCH MATCHES "x86")
    set(MSBUILD_PLATFORM "Win32")
  else()
    set(MSBUILD_PLATFORM ${TRIPLET_SYSTEM_ARCH})
  endif()

  if(VCPKG_PLATFORM_TOOLSET STREQUAL "v140")
    set(VC_SUB_DIR "vc14")
  elseif(VCPKG_PLATFORM_TOOLSET STREQUAL "v141")
    set(VC_SUB_DIR "vc141")
  elseif(VCPKG_PLATFORM_TOOLSET STREQUAL "v142")
    set(VC_SUB_DIR "vc142")
  else()
    message(FATAL_ERROR "Unsupported platform toolset.")
  endif()

  vcpkg_build_msbuild(
    PROJECT_PATH ${ARABICA_PROJECTS_PATH}/Arabica.sln
    PLATFORM ${MSBUILD_PLATFORM}
    USE_VCPKG_INTEGRATION
  )

  function(install_arabica_headers_subdirectory ORIGINAL_PATH RELATIVE_PATH)
  file(GLOB HEADER_FILES ${ORIGINAL_PATH}/${RELATIVE_PATH}/*.hpp ${ORIGINAL_PATH}/${RELATIVE_PATH}/*.inl)
  file(INSTALL ${HEADER_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include/${RELATIVE_PATH})
  endfunction()

  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "Arabica")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "convert")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "convert/impl")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "DOM")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "DOM/DualMode")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "DOM/Events")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "DOM/io")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "DOM/SAX2DOM")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "DOM/Simple")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "DOM/Traversal")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "io")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "SAX")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "SAX/ext")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "SAX/filter")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "SAX/helpers")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "SAX/parsers")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "SAX/wrappers")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "Taggle")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "Taggle/impl")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "Taggle/impl/html")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "text")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "XML")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "XPath")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "XPath/impl")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "XSLT")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "XSLT/impl")
  install_arabica_headers_subdirectory(${ARABICA_INCLUDE_PATH} "XSLT/impl/handler")

  set(ARABICA_OUTPUT_PATH ${ARABICA_ROOT}/${VC_SUB_DIR}/${TRIPLET_SYSTEM_ARCH})
  file(INSTALL ${ARABICA_OUTPUT_PATH}/Debug/Arabica.lib   DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
  file(INSTALL ${ARABICA_OUTPUT_PATH}/Release/Arabica.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

else(VCPKG_TARGET_IS_WINDOWS)

  vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS -DADDITIONAL_INC:PATH=${VCPKG_ROOT_DIR}/installed/${TARGET_TRIPLET}/include
  )
  vcpkg_install_cmake()
  vcpkg_copy_pdbs()

endif()

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/arabica RENAME copyright)
