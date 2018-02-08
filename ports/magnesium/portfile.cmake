include(vcpkg_common_functions)

set(PROJECT_NAME "magnesium")
set(SOURCE_PATH "${CURRENT_BUILDTREES_DIR}/src/${PROJECT_NAME}")

#architecture detection
if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
   set(PROJECT_ARCH 32)
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
   set(PROJECT_ARCH "")
else()
   message(FATAL_ERROR "unsupported architecture")
endif()

set(PROJECT_RELEASE "Release")
set(PROJECT_DEBUG "Debug")
#linking
if (NOT VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
  set(PROJECT_RELEASE "Release-Static")
  set(PROJECT_DEBUG "Debug-Static")
  set(PROJECT_SUFFIX "_s")
endif()

if(EXISTS "${CURRENT_BUILDTREES_DIR}/src/.git")
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/src)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO black-sphere-studios/${PROJECT_NAME}
    REF 25ad607e59cef1fb4a22852f753dadb602fba089
    SHA512 11223eee284dfad33038c95d329519aa8676f35ebf0a6b95bbe5aeafef79d2727c13cfda3a7911c9c0f5780ad714a260a3b03f3323005cca75df645069385b0c
    HEAD_REF master
)

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/${PROJECT_NAME}/${PROJECT_NAME}.vcxproj
    RELEASE_CONFIGURATION ${PROJECT_RELEASE}
    DEBUG_CONFIGURATION ${PROJECT_DEBUG}
    OPTIONS /p:ForceImportBeforeCppTargets=${VCPKG_ROOT_DIR}/scripts/buildsystems/msbuild/vcpkg.targets
)

message(STATUS "Installing")
if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    file(INSTALL
        ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}_d.pdb
        DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib
    )
    file(INSTALL
        ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}.pdb
        DESTINATION ${CURRENT_PACKAGES_DIR}/lib
    )
else()
    file(INSTALL
        ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}_d_s.pdb
        DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib
    )
    file(INSTALL
        ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}_s.pdb
        DESTINATION ${CURRENT_PACKAGES_DIR}/lib
    )
endif()

file(INSTALL
    ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}_d${PROJECT_SUFFIX}.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib
)
file(INSTALL
    ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}${PROJECT_SUFFIX}.lib
    DESTINATION ${CURRENT_PACKAGES_DIR}/lib
)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PROJECT_NAME} RENAME copyright)

file(
    INSTALL ${SOURCE_PATH}/include
    DESTINATION ${CURRENT_PACKAGES_DIR}
    FILES_MATCHING PATTERN "*.h"
)

message(STATUS "Installing done")
