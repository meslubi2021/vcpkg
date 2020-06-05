vcpkg_fail_port_install(MESSAGE "${PORT} currently only supports being built for desktop" ON_TARGET "UWP")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO openresty/luajit2
    REF v2.1-20200102
    SHA512 d363e48eea2c0145f7c198b30685a40c02e02ab2e5cb8b076b07735d05f28cb2e3651d5464ca2423845455e6afbfbc9a9d92aa363a42b2743e6bd89ad16f227d
    HEAD_REF master
    PATCHES
        001-fix-build-path.patch
        002-fix-crt-linkage.patch
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	set (LJIT_STATIC "")
else()
	set (LJIT_STATIC "static")
endif()

if (NOT VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL debug)
    message(STATUS "Building ${TARGET_TRIPLET}-dbg")
    file(REMOVE_RECURSE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
    file(MAKE_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
    
    vcpkg_execute_required_process_repeat(
        COUNT 1
        COMMAND "${SOURCE_PATH}/src/msvcbuild.bat" ${SOURCE_PATH}/src ${VCPKG_CRT_LINKAGE} debug ${LJIT_STATIC}
        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
        LOGNAME build-${TARGET_TRIPLET}-dbg
    )
    
    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/luajit.exe DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools)
    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lua51.lib  DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
    
    if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
        file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lua51.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
        file(COPY ${CURRENT_PACKAGES_DIR}/debug/bin/lua51.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/tools)
    endif()
    vcpkg_copy_pdbs()
endif()


if (NOT VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL release)
    message(STATUS "Building ${TARGET_TRIPLET}-rel")
    file(REMOVE_RECURSE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
    file(MAKE_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
    
    vcpkg_execute_required_process_repeat(d8un
        COUNT 1
        COMMAND "${SOURCE_PATH}/src/msvcbuild.bat" ${SOURCE_PATH}/src ${VCPKG_CRT_LINKAGE} ${LJIT_STATIC}
        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
        LOGNAME build-${TARGET_TRIPLET}-rel
    )
    
    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/luajit.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools)
    file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lua51.lib  DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
    
    if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
        file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lua51.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
        vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools)
    endif()
    vcpkg_copy_pdbs()
endif()

file(INSTALL ${SOURCE_PATH}/src/lua.h 			    DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
file(INSTALL ${SOURCE_PATH}/src/luajit.h 	    	DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
file(INSTALL ${SOURCE_PATH}/src/luaconf.h 		    DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
file(INSTALL ${SOURCE_PATH}/src/lualib.h 		    DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
file(INSTALL ${SOURCE_PATH}/src/lauxlib.h 		    DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
file(INSTALL ${SOURCE_PATH}/src/lua.hpp 		    DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})

# Handle copyright
file(COPY ${SOURCE_PATH}/COPYRIGHT DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})