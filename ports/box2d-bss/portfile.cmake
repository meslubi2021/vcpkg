
# Get output directory
set(PROJECT_ARCH_BITS "64")
if(TRIPLET_SYSTEM_ARCH MATCHES "x86")
    set(PROJECT_ARCH_BITS "32")
elseif(TRIPLET_SYSTEM_ARCH MATCHES "arm")
    message(FATAL_ERROR "ARM not supported")
endif(TRIPLET_SYSTEM_ARCH MATCHES "x86")


include(vcpkg_common_functions)

if(EXISTS "${CURRENT_BUILDTREES_DIR}/src/.git")
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/src)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO black-sphere-studios/Box2D
    REF dbc4e018d4594d768c7df30eb3a74672694f7fe1
    SHA512 58dcf5780b33f24a866abc0be1f521ad60760f1a3ea2f52198b16debeeea6aa20e44699b658160a38f1c53d037c099edc7ffee49ccd5992a8797c1d111d77834
    HEAD_REF master
)

# Put the licence and readme files where vcpkg expects it
message(STATUS "Packaging license")
file(COPY ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/box2d-bss)
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/box2d-bss)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/box2d-bss/LICENSE ${CURRENT_PACKAGES_DIR}/share/box2d-bss/copyright)
message(STATUS "Packaging license done")

# Building:
set(OUTPUTS_PATH "${SOURCE_PATH}/Box2D/Build/vs2017/bin${PROJECT_ARCH_BITS}")

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/Box2D/Build/vs2017/Box2D.vcxproj
)

message(STATUS "Packaging ${TARGET_TRIPLET}-Release lib")
file(
    INSTALL ${OUTPUTS_PATH}/Release/
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib
    FILES_MATCHING PATTERN "*.lib"
)
message(STATUS "Packaging ${TARGET_TRIPLET}-Release lib done")

message(STATUS "Packaging ${TARGET_TRIPLET}-Debug lib")
file(
    INSTALL ${OUTPUTS_PATH}/Debug/
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib
    FILES_MATCHING PATTERN "*.lib"
)
message(STATUS "Packaging ${TARGET_TRIPLET}-Debug lib done")

message(STATUS "Packaging headers")
file(
    COPY ${SOURCE_PATH}/Box2D/Box2D
    DESTINATION ${CURRENT_PACKAGES_DIR}/include
    PATTERN "*.h"
)
message(STATUS "Packaging headers done")

vcpkg_copy_pdbs()
