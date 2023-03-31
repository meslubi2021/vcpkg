# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/xpressive
    REF boost-1.81.0
    SHA512 d26f774c51e5fee21e8f799c8b7a076d4ee104c0d9f5e74c11c09a9d2b1799cbe38f31107b8042309c8b5a893d36b7382aa07604aa053a686ce4c9b4fb812919
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
