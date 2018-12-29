# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/optional
    REF boost-1.68.0
    SHA512 995436e8805a441e13a3fb8040b78dde9363759bd49db789744ba5afe1a90af05b05de882267aef1c76fe68c410172233e2c8b0559e74f6764b3b1a1207a6b9b
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
