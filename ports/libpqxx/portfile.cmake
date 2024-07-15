vcpkg_download_distfile(CMAKE_3_30_PATCH
    URLS "https://github.com/jtv/libpqxx/commit/0444b8bcbd82679b9b22792e0f9ef74653c0b3fa.patch?full_index=1"
    FILENAME "libpqxx-cmake-3-30-0444b8bcbd82679b9b22792e0f9ef74653c0b3fa.patch"
    SHA512 fc6071b2c3a67670675b640b87d98675a77757fae73d84fb9acd0b9535f70a8c3e6d2b122a847f1473bbd581f67aa4e52f337fd1237fa8a02ff47c6a1284deed
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jtv/libpqxx
    REF "${VERSION}"
    SHA512 134e28177f6a205c8a45462fa6b3cb4c407ab8f03a45708400fdc9f567d2ba1fae9cce9d541bdccd46694bf5d1b8dfd72bc6de5f6c915181909623357f86ce47
    HEAD_REF master
    PATCHES
        fix_build_with_vs2017.patch
        "${CMAKE_3_30_PATCH}"
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/config-public-compiler.h.in" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/config-internal-compiler.h.in" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DSKIP_BUILD_TEST=ON
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/libpqxx)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

vcpkg_fixup_pkgconfig()
