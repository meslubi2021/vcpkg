# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/conversion
    REF boost-1.81.0
    SHA512 97d385dd4693890b60a2971851f4c27ae01a4d451c1e6b8d42500b7dcab8e668067931c2d4cf3ddb123b7a3f5bdf211daa77615b264b28c480119692156d839b
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
