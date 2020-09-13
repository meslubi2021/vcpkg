#!/usr/bin/env python

import os
import subprocess

x64OnlyPackageList = [
    "chromium-base"
]

packageList = [
    (['boost-locale[icu]', 'boost-regex[icu]', 'boost[mpi]', 'icu', 'mpi'], False),

    (['7zip'], False),
    (['abseil', 'abseil[cxx17]'] , False),
    (['aixlog'], False),
    (['akali'], False),
    (['angelscript', 'angelscript[addons]'], False),
    (['antlr4'], False),
    (['apr', 'apr-util'], False),
    (['arabica', 'winsock2'], False),
    (['asmjit'] , False),
    (['atk', 'atkmm', 'gtk', 'gtkmm'], False),
    (['audiofile'] , False),
    (['bdwgc'], False),
    (['benchmark'], False),
    (['berkeleydb'], False),
    (['bigint'], False),
    (['bustache'] , False),
    (['capstone', 'capstone[x86]', 'cccapstone'] , False),
    (['catch2'] , False),
    (['chaiscript'], False),
    (['chakracore'], False),
    (['check'], False),
    (['chmlib'], False),
    # (['chromium-base'], False),
    (['constexpr'], False),
    (['cpp-base64'], False),
    (['cpprestsdk'] , False),
    (['cpptoml'] , False),
    (['cppunit'], False),
    (['cpu-features', 'cpu-features[tools]'], False),
    (['cpuid'], False),
    (['cpuinfo', 'cpuinfo[tools]'], False),
    (['crossguid'], False),
    (['ctbignum'], False),
    (['detours'], False),
    (['dirent'], False),
    (['directxsdk', 'directxtk12', 'dx'], False),
    (['discount'], False),
    (['distorm'], False),
    (['dlfcn-win32'], False),
    (['duilib'] , False),
    (['duktape'], False),
    (['eastl'] , False),
    (['ecm'] , False),
    (['exiv2', 'exiv2[unicode]'], False),
    (['fast-cpp-csv-parser'], False),
    (['flatbuffers', 'glog', 'gtest', 'protobuf', 'protobuf[zlib]'], False),
    (['fltk'], False),
    (['fmt'], False),
    (['foonathan-memory', 'foonathan-memory[tool]'], False),
    (['fplus'], False),
    (['freeglut'], False),
    (['fruit'], False),
    (['function2'], False),
    (['getopt'], False),
    (['gettimeofday'], False),
    (['glew', 'glui'], False),
    (['hunspell', 'hunspell[tools]'], False),
    (['imgui', 'imgui[glfw-binding]', 'imgui[glut-binding]', 'imgui[sdl2-binding]', 'imgui[win32-binding]', 'imgui-sfml', 'sdl2', 'sdl2-gfx', 'sdl2-image', 'sdl2-image[libjpeg-turbo]', 'sdl2-image[libwebp]', 'sdl2-image[tiff]', 'sdl2-mixer', 'sdl2-mixer[nativemidi]', 'sdl2-net', 'sdl2-ttf', 'sdl2pp'], False),
    (['jansson'] , False),
    (['jbigkit'], False),
    (['jemalloc'] , False),
    (['json-spirit'] , False),
    (['json11'] , False),
    (['libevent', 'libevent[thread]'], False),
    (['libguarded'] , False),
    (['libsndfile'], False),
    (['libui'], False),
    (['libxml2'], False),
    (['libyaml'] , False),
    # (['llvm', 'llvm[clang-tools-extra]', 'llvm[utils]'], False),
    (['lua', 'lua[cpp]', 'luabridge', 'luafilesystem'], False),
    (['magic-enum'], False),
    (['mimalloc', 'mimalloc[secure]'] , False),
    (['mhook'], False),
    (['minhook'], False),
    (['mman'], False),
    (['mpfr'] , False),
    (['mpg123'], False),
    (['mp3lame'], False),
    (['ms-gsl'], False),
    (['msinttypes'], False),
    (['mstch'], False),
    (['mujs'], False),
    (['mygui', 'mygui[opengl]'] , False),
    (['nana'], False),
    (['nanogui'], False),
    (['nt-wrapper'], False),
    (['nuklear'], False),
    (['numcpp'], False),
    (['openal-soft'], False),
    (['opencv4'], False),
    (['openjpeg'], False),
    (['pdcurses'], False),
    (['p-ranav-csv2'], False),
    (['phnt'], False),
    (['platform-folders'], False),
    (['poco', 'sqlite3', 'sqlite3[tool]', 'sqlitecpp', 'sqlite-modern-cpp'], False),
    # (['portaudio'], False),
    (['pprint'], False),
    (['pthreads'], False),
    (['pugixml'], False),
    (['pystring'], False),
    (['qt5', 'qwt', 'qt5[doc]', 'qt5[speech]', 'qt5-winextras'], False),
    (['range-v3'], False),
    (['rapidxml'], False),
    (['rttr'], False),
    (['safeint'], False),
    (['scintilla'], False),
    (['sfgui'], False),
    (['strtk'], False),
    (['tgc'], False),
    (['tgui', 'tgui[tool]'] , False),
    (['tidy-html5'], False),
    (['tinyxml'], False),
    (['utf8h', 'utfcpp'] , False),
    (['v8'], False),
    (['wil'] , False),
    (['winreg'], False),
    (['wtl'], False),
    (['wxwidgets'], False),
    (['xerces-c[icu]'], False),
    (['yasm'], False),

    # (['dlib'], False),
]

def common_member(a, b): 
    a_set = set(a)
    b_set = set(b)
    if len(a_set.intersection(b_set)) > 0:
        return(True)
    return(False)

def InstallPackagesWorker(packages, triplet, recurse):
    args = []
    args.append("vcpkg")
    args.append("install")
    args.extend(packages)
    args.append("--triplet")
    args.append(triplet)
    if (recurse):
        args.append("--recurse")
    try:
        seperator = ' '
        print("Calling '%s'." % seperator.join(args))
        subprocess.check_call(args)
        return True
    except subprocess.CalledProcessError as err:
        return False
    except OSError as err:
        return False

def InstallPackages(packages, recurse):
    print()
    print("################################################################################")
    print("Installing packages: %s" % packages)
    print("################################################################################")
    print()
    print("+++++++++++++++++")
    print("++ x64-windows ++")
    print("+++++++++++++++++")
    print()
    ret = InstallPackagesWorker(packages, "x64-windows", recurse)
    if (not ret):
        return False
    if (common_member(x64OnlyPackageList, packages)):
        return ret
    print()
    print("+++++++++++++++++")
    print("++ x86-windows ++")
    print("+++++++++++++++++")
    print()
    ret = InstallPackagesWorker(packages, "x86-windows", recurse)
    print()
    return ret

def InstallPackagesInPackageList():
    for package in packageList:
         ret = InstallPackages(package[0], package[1])
         if ret == False:
             return False
    return True

InstallPackagesInPackageList()
