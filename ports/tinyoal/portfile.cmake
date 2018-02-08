include(vcpkg_common_functions)

set(PROJECT_NAME "tinyoal")
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
    REF 2978bf0a22ed2ea675e583cbd610080e3f94378e
    SHA512 c07da4e945249df7c2bd77c062bab760b14eb06dfa1ccad93b4d954913284d2b97789c7d776e37aea8c857776a24c230c9e1c1e4efec7d779b200d165a8969e6
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
        ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}_d.dll
        ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}_d.pdb
        DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin
    )
    file(INSTALL
        ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}.dll
        ${SOURCE_PATH}/bin${PROJECT_ARCH}/${PROJECT_NAME}${PROJECT_ARCH}.pdb
        DESTINATION ${CURRENT_PACKAGES_DIR}/bin
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
