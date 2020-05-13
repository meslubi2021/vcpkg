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

vcpkg_configure_cmake(
  SOURCE_PATH ${SOURCE_PATH}
  PREFER_NINJA
  OPTIONS
    -DBUILD_ARABICA_EXAMPLES=OFF
    -DBUILD_WITH_BOOST=ON
)
vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/arabica RENAME copyright)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
