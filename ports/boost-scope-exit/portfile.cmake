# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/scope_exit
    REF boost-1.82.0
    SHA512 b759a1c6df861562b3396ee3753a955fbf47d9aac96fa5299de96bd1d27b58e4c2354dfea1efde9af4b77108227346ab5fc81ca50ceb06d5056f0231b0f3028d
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
