
# Get output directory
if(TRIPLET_SYSTEM_ARCH MATCHES "x64" AND VCPKG_PLATFORM_TOOLSET MATCHES "v140")
  set(PROJECT_GENERATOR "Visual Studio 14 2015 Win64")
elseif(TRIPLET_SYSTEM_ARCH MATCHES "x86" AND VCPKG_PLATFORM_TOOLSET MATCHES "v140")
  set(PROJECT_GENERATOR "Visual Studio 14 2015")
elseif(TRIPLET_SYSTEM_ARCH MATCHES "x64" AND VCPKG_PLATFORM_TOOLSET MATCHES "v141")
  set(PROJECT_GENERATOR "Visual Studio 15 2017 Win64")
elseif(TRIPLET_SYSTEM_ARCH MATCHES "x86" AND VCPKG_PLATFORM_TOOLSET MATCHES "v141")
  set(PROJECT_GENERATOR "Visual Studio 15 2017")
elseif(TRIPLET_SYSTEM_ARCH MATCHES "arm")
  message(FATAL_ERROR "ARM not supported")
endif()

include(vcpkg_common_functions)

if(EXISTS "${CURRENT_BUILDTREES_DIR}/src/.git")
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/src)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/liquidfun
    REF 0708ce1464b0db3cf34353258ce939a82f28a173
    SHA512 c2694989c340fd7a7e6d9ff9a0ac371620182685f86dd2822c668e14ab5e8335dbe417c3bd892d717a39ab1f86b49e49eae2688faedab8ae521f507d48379320
    HEAD_REF master
)

# Put the licence and readme files where vcpkg expects it
message(STATUS "Packaging license")
file(COPY ${SOURCE_PATH}/liquidfun/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/liquidfun)
file(COPY ${SOURCE_PATH}/liquidfun/Box2D/License.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/liquidfun)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/liquidfun/License.txt ${CURRENT_PACKAGES_DIR}/share/liquidfun/copyright)
message(STATUS "Packaging license done")
 
vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}/liquidfun/Box2D
    PATCHES ${CURRENT_PORT_DIR}/0001-fix-cmake.patch
)

file(REMOVE_RECURSE ${SOURCE_PATH}/liquidfun/Box2D/CMakeFiles)
file(REMOVE ${SOURCE_PATH}/liquidfun/Box2D/CMakeCache.txt)

# Building:
execute_process(
  COMMAND ${CMAKE_COMMAND}
    -G ${PROJECT_GENERATOR}
  WORKING_DIRECTORY ${SOURCE_PATH}/liquidfun/Box2D
)

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}/liquidfun/Box2D
    PATCHES ${CURRENT_PORT_DIR}/0002-fix-pdb.patch
    PATCHES ${CURRENT_PORT_DIR}/0003-fix-runtime.patch
)

vcpkg_build_msbuild(PROJECT_PATH ${SOURCE_PATH}/liquidfun/Box2D/Box2D/Box2D.vcxproj)

message(STATUS "Packaging ${TARGET_TRIPLET}-Release lib")
file(
    INSTALL ${SOURCE_PATH}/liquidfun/Box2D/Box2D/Release/
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib
    FILES_MATCHING PATTERN "*.lib"
)
file(
    INSTALL ${SOURCE_PATH}/liquidfun/Box2D/Box2D/Release/
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib
    FILES_MATCHING PATTERN "*.pdb"
)
message(STATUS "Packaging ${TARGET_TRIPLET}-Release lib done")

message(STATUS "Packaging ${TARGET_TRIPLET}-Debug lib")
file(
    INSTALL ${SOURCE_PATH}/liquidfun/Box2D/Box2D/Debug/
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib
    FILES_MATCHING PATTERN "*.lib"
)
file(
    INSTALL ${SOURCE_PATH}/liquidfun/Box2D/Box2D/Debug/
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib
    FILES_MATCHING PATTERN "*.pdb"
)
message(STATUS "Packaging ${TARGET_TRIPLET}-Debug lib done")

message(STATUS "Packaging headers")
file(
    COPY ${SOURCE_PATH}/liquidfun/Box2D/Box2D
    DESTINATION ${CURRENT_PACKAGES_DIR}/include
    FILES_MATCHING PATTERN "*.h"
)
file(REMOVE_RECURSE 
  ${CURRENT_PACKAGES_DIR}/include/Box2D/Release
  ${CURRENT_PACKAGES_DIR}/include/Box2D/x64
  ${CURRENT_PACKAGES_DIR}/include/Box2D/Documentation
  ${CURRENT_PACKAGES_DIR}/include/Box2D/Debug
  ${CURRENT_PACKAGES_DIR}/include/Box2D/Box2D.dir
  ${CURRENT_PACKAGES_DIR}/include/Box2D/CMakeFiles
)
message(STATUS "Packaging headers done")


vcpkg_copy_pdbs()
