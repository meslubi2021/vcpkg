include(vcpkg_common_functions)

if (NOT VCPKG_TARGET_IS_WINDOWS)
    message(FATAL_ERROR "This port currently only supports Windows.")
endif()

if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    message(FATAL_ERROR "This port does not currently support architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

find_program(NMAKE nmake)

set(TERRA_VERSION 1.0.0-beta1)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/zdevito/terra/archive/release-${TERRA_VERSION}.tar.gz"
    FILENAME "terra-cache/release-${TERRA_VERSION}.tar.gz"
    SHA512 8c6aa4654d3b46709c683a88b413671a5cf0a237c409d4c663ea42a3f9eca2262461fd3afb1c585f1dd3e4dcfeddc083ec32cd5331c47311498d3b35e263dbbc
)
vcpkg_extract_source_archive(${ARCHIVE})

set(LLVM_VERSION 6.0.1)
set(LLVM_VERSION_SHORT 60)
set(VS_MAJOR_VERSION 14)
set(BINARY_SOURCE_USER Mx7f)
vcpkg_download_distfile(LLVM_ARCHIVE
    URLS "https://github.com/${BINARY_SOURCE_USER}/llvm-package-windows/releases/download/clang-${LLVM_VERSION}-nvptx/llvm-${LLVM_VERSION}-windows-amd64-msvc${VS_MAJOR_VERSION}-msvcrt.7z"
    FILENAME "terra-cache/llvm-${LLVM_VERSION}-windows-amd64-msvc${VS_MAJOR_VERSION}-msvcrt.7z"
    SHA512 6d56f6079cb4911bfd850c72026dae6a7ea60130b3316b659c291515fef4e08ba1a8b8982d57334f28be513d9f8c82256f5b874a2c2d4fba2380ad77daffc07f
)
vcpkg_extract_source_archive(${LLVM_ARCHIVE})

set(LUAJIT_VERSION 2.0.5)
vcpkg_download_distfile(LUAJIT_ARCHIVE
    URLS "http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz"
    FILENAME "terra-cache/LuaJIT-${LUAJIT_VERSION}.tar.gz"
    SHA512 2636675602b4a060b0571c05220db2061dd2f38568e35b2be346a0f5e3128d87057d11d3d0d7567d8cc4e0817b5e4cf2c52a17a48065520962b157816465a9fe
)
vcpkg_extract_source_archive(${LUAJIT_ARCHIVE})

set(LLVM_DIR ${CURRENT_BUILDTREES_DIR}/src/llvm-${LLVM_VERSION}-windows-amd64-msvc${VS_MAJOR_VERSION}-msvcrt)
set(LUAJIT_DIR ${CURRENT_BUILDTREES_DIR}/src/LuaJIT-${LUAJIT_VERSION})
set(TERRA_DIR ${CURRENT_BUILDTREES_DIR}/src/terra-release-${TERRA_VERSION})

vcpkg_apply_patches(
    SOURCE_PATH ${TERRA_DIR}
    PATCHES temp-fix.patch
)

file(TO_NATIVE_PATH "${LLVM_DIR}" NATIVE_LLVM_DIR)
file(TO_NATIVE_PATH "${LUAJIT_DIR}" NATIVE_LUAJIT_DIR)
file(TO_NATIVE_PATH "${TERRA_DIR}" NATIVE_TERRA_DIR)

set(ENV{LLVM_DIR} ${NATIVE_LLVM_DIR})
set(ENV{LLVM_VERSION} ${LLVM_VERSION})
set(ENV{LLVM_VERSION_SHORT} ${LLVM_VERSION_SHORT})
set(ENV{LUAJIT_DIR} ${NATIVE_LUAJIT_DIR})
set(ENV{TERRA_DIR} ${NATIVE_TERRA_DIR})
set(ENV{TERRA_VERSION} ${TERRA_VERSION})
set(ENV{VS_MAJOR_VERSION} ${VS_MAJOR_VERSION})
set(ENV{VS_MINOR_VERSION} 0)

vcpkg_execute_required_process(
    COMMAND ${NMAKE}
    WORKING_DIRECTORY ${TERRA_DIR}/msvc
    LOGNAME build-${TARGET_TRIPLET}
)

file(GLOB RELEASE ${TERRA_DIR}/release/*)
file(COPY ${RELEASE} DESTINATION ${CURRENT_PACKAGES_DIR})

file(COPY ${CURRENT_PACKAGES_DIR}/bin/terra.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/terra)
file(REMOVE ${CURRENT_PACKAGES_DIR}/bin/terra.exe)
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/terra)

file(RENAME ${CURRENT_PACKAGES_DIR}/share/terra/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/terra/copyright)