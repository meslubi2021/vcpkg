#!/usr/bin/env python

import os
import subprocess

packageList = [
    (['boost[mpi]', 'icu', 'mpi'], False),

    (['abseil', 'abseil[cxx17]'] , False),
    (['angelscript', 'angelscript[addons]'], False),
    (['antlr4'], False),
    (['apr', 'apr-util'], False),
    (['arabica'], False),
    (['asmjit'] , False),
    (['bdwgc'], False),
    (['benchmark'], False),
    (['bigint'], False),
    (['boringssl', 'boringssl[tools]'], False),
    (['bustache'] , False),
    (['capstone', 'capstone[x86]', 'cccapstone'] , False),
    (['catch2'] , False),
    (['chaiscript'], False),
    (['check'], False),
    (['chmlib'], False),
    (['constexpr'], False),
    (['cpp-base64'], False),
    (['cpprestsdk'] , False),
    (['cpptoml'] , False),
    (['cpuid'], False),
    (['cpuinfo', 'cpuinfo[tools]'], False),
    (['crossguid'], False),
    (['detours'], False),
    (['dirent'], False),
    (['discount'], False),
    (['distorm'], False),
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
    (['getopt'], False),
    (['glui'], False),
    (['imgui', 'imgui[bindings]', 'imgui-sfml'], False),
    (['jansson'] , False),
    (['jbigkit'], False),
    (['jemalloc'] , False),
    (['json-spirit'] , False),
    (['json11'] , False),
    (['libguarded'] , False),
    (['libsndfile'], False),
    (['libui'], False),
    (['libxml2'], False),
    (['llvm', 'llvm[clang-tools-extra]', 'llvm[utils]'], False),
    (['lua', 'lua[cpp]', 'luabridge', 'luafilesystem'], False),
    (['magic-enum'], False),
    (['mhook'], False),
    (['minhook'], False),
    (['mman'], False),
    (['mpg123'], False),
    (['mp3lame'], False),
    (['ms-gsl'], False),
    (['msinttypes'], False),
    (['mstch'], False),
    (['mujs'], False),
    (['nana'], False),
    (['nanogui'], False),
    (['nuklear'], False),
    (['openal-soft'], False),
    (['opencv4'], False),
    (['openjpeg'], False),
    (['pdcurses'], False),
    (['platform-folders'], False),
    (['poco', 'sqlite3', 'sqlite3[tool]', 'sqlitecpp', 'sqlite-modern-cpp'], False),
    (['portaudio'], False),
    (['pprint'], False),
    (['pthreads'], False),
    (['pugixml'], False),
    (['pystring'], False),
    (['qt5', 'qwt'], False),
    (['range-v3'], False),
    (['rapidxml'], False),
    (['rttr'], False),
    (['scintilla'], False),
    (['sdl2', 'sdl2-net', 'sdl2-ttf', 'sdl2pp'], False),
    (['sfgui'], False),
    (['strtk'], False),
    (['tgc'], False),
    (['tidy-html5'], False),
    (['tinyxml'], False),
    (['wil'] , False),
    (['wxwidgets'], False),
    (['xerces-c[icu]'], False),
    (['yasm'], False),

    (['dlib'], False),
]


def InstallPackagesWorker(packages, triplet, recurse):
    args = []
    args.append("./vcpkg")
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
    ret = InstallPackagesWorker(packages, "x64-linux", recurse)
    print()
    return ret

def InstallPackagesInPackageList():
    for package in packageList:
         ret = InstallPackages(package[0], package[1])
         if ret == False:
             return False
    return True

InstallPackagesInPackageList()
