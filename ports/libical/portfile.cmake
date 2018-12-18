include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libical/libical
    REF v3.0.4
    SHA512 acb95bf3dba8e89c0cfb91023ae340478d695b50aad8c282acda33cab4712a12d55c6d3bf1b572e0e6eae162ef40fd783b47a05a7654fa9dde78a0542e3dad7a
    HEAD_REF master
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    set(libical_SHARED_ONLY ON)
else()
    set(libical_SHARED_ONLY OFF)
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(libical_STATIC_ONLY ON)
else()
    set(libical_STATIC_ONLY OFF)
endif()

# libical require perl to be available for the cmake build
vcpkg_find_acquire_program(PERL)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DSHARED_ONLY=${libical_SHARED_ONLY}
        -DSTATIC_ONLY=${libical_STATIC_ONLY}
        -DICAL_GLIB=OFF
        -DICAL_BUILD_DOCS=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

# Move CMake config files to the right place
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/LibIcal)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libical RENAME copyright)
