cmake_minimum_required(VERSION 3.11)
project(wasmer)

include(ExternalProject)

# add_library(wasmer STATIC IMPORTED)

set_directory_properties(PROPERTIES EP_PREFIX ${CMAKE_BINARY_DIR}/rust-build)
ExternalProject_Add(
        wasmer_c_api
        DOWNLOAD_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND "make build-capi"
        COMMAND "make build-capi"
        BINARY_DIR "${CMAKE_SOURCE_DIR}/rust-build/src/wasmer-runtime-c-api/"
        INSTALL_COMMAND ""
        INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}"
        LOG_BUILD ON)

# add_custom_command(TARGET wasmer PRE_BUILD
#     COMMAND cargo build -p wasmer-runtime-c-api 
#     BYPRODUCTS ${CMAKE_SOURCE_DIR}/rust-build/src/wasmer-runtime-c-api/)

      

# add_dependencies(wasmer wasmer-runtime-c-api)

if(WIN32)
    set(WASMER_LIB "${CMAKE_SOURCE_DIR}/rust-build/src/wasmer-runtime-c-api/target/debug/wasmer_runtime_c_api.dll")
else()
    set(WASMER_LIB "${CMAKE_SOURCE_DIR}/rust-build/src/wasmer-runtime-c-api/target/debug/libwasmer_runtime_c_api${CMAKE_SHARED_LIBRARY_SUFFIX}")
endif()

# target_link_libraries(wasmer ${WASMER_LIB})

install( FILES "${WASMER_LIB}"
    # ARCHIVE 
    DESTINATION "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
    # PUBLIC_HEADER DESTINATION "include/wasmer"
)
install( FILES "${CMAKE_CURRENT_SOURCE_DIR}/include/wasmer.hh"
    # ARCHIVE 
    DESTINATION "${CMAKE_INSTALL_PREFIX}/include"
    # PUBLIC_HEADER DESTINATION "include/wasmer"
)
# install(TARGETS wasmer DESTINATION ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR})

# # Refs: https://gitlab.kitware.com/cmake/community/-/wikis/doc/tutorials/Exporting-and-Importing-Targets

# add_library(wasmer STATIC IMPORTED)

# set_property(TARGET wasmer PROPERTY IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/lib/libwasmer.a")
# # set_target_properties(wasmer PROPERTIES INTERFACE_INCLUDE_DIRECTORIES  "${CMAKE_CURRENT_SOURCE_DIR}/include")
# target_include_directories(wasmer INTERFACE
#   $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/wasmer>
#   $<INSTALL_INTERFACE:include/wasmer>  # <prefix>/include/wasmer
# )

# # message(FATAL_ERROR "CMAKE_INSTALL_LIBDIR: ${CMAKE_INSTALL_LIBDIR}")
# # message(FATAL_ERROR "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")

# install( FILES "${CMAKE_CURRENT_SOURCE_DIR}/lib/libwasmer.a"
#     # ARCHIVE 
#     DESTINATION "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
#     # PUBLIC_HEADER DESTINATION "include/wasmer"
# )
# install( FILES "${CMAKE_CURRENT_SOURCE_DIR}/include/wasmer.hh"
#     # ARCHIVE 
#     DESTINATION "${CMAKE_INSTALL_PREFIX}/include"
#     # PUBLIC_HEADER DESTINATION "include/wasmer"
# )
# # if(NOT DISABLE_INSTALL_HEADERS)
# # install( FILES wasmer PUBLIC_HEADER DESTINATION include/alac)
# # endif()
# # install( FILES wasmer PUBLIC_HEADER 
# #     DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/wasmer
# # )