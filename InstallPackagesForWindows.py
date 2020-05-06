#!/usr/bin/env python

import os
import subprocess

packageList = [
    (['mpi', 'icu'], False),
    (['boost-locale[icu]', 'boost-regex[icu]', 'boost[mpi]'], True),

    (['abseil'] , False),
    (['angelscript', 'angelscript[addons]'], False),
    (['antlr4'], False),
    (['apr', 'apr-util'], False),
    (['asmjit'] , False),
    (['atk', 'atkmm', 'gtk', 'gtkmm'], False),
    (['bdwgc'], False),
    (['bigint'], False),
    (['bustache'] , False),
    (['capstone', 'capstone[x86]', 'cccapstone'] , False),
    (['catch2'] , False),
    (['chaiscript'], False),
    (['chakracore'], False),
    (['constexpr'], False),
    (['cpprestsdk'] , False),
    (['cpptoml'] , False),
    (['cppunit'], False),
    (['detours'], False),
    (['dirent'], False),
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
    (['gettimeofday'], False),
    (['glui'], False),
    (['imgui', 'imgui[example]', 'imgui-sfml'], False),
    (['jbigkit'], False),
    (['json-spirit'] , False),
    (['json11'] , False),
    (['libguarded'] , False),
    (['libsndfile'], False),
    (['libui'], False),
    (['libxml2'], False),
    (['llvm', 'llvm[tools]', 'llvm[utils]', 'llvm[example]'], False),
    (['lua', 'lua[cpp]', 'luabridge'], False),
    (['mhook'], False),
    (['minhook'], False),
    (['mman'], False),
    (['mp3lame'], False),
    (['ms-gsl'], False),
    (['msinttypes'], False),
    (['nana'], False),
    (['nanogui'], False),
    (['nuklear'], False),
    (['openal-soft'], False),
    (['opencv4'], False),
    (['openjpeg'], False),
    (['pdcurses'], False),
    (['platform-folders'], False),
    (['poco'], False),
    (['portaudio'], False),
    (['pprint'], False),
    (['pthreads'], False),
    (['pugixml'], False),
    (['pystring'], False),
    (['qt5'], False),
    (['range-v3'], False),
    (['rapidxml'], False),
    (['rttr'], False),
    (['scintilla'], False),
    (['sdl2', 'sdl2-net', 'sdl2-ttf', 'sdl2pp'], False),
    (['sfgui'], False),
    (['sqlite3', 'sqlite3[tool]', 'sqlitecpp', 'sqlite-modern-cpp'], True),
    (['strtk'], False),
    (['tidy-html5'], False),
    (['tinyxml'], False),
    (['wil'] , False),
    (['winsock2'], False),
    (['wtl'], False),
    (['wxwidgets'], False),
    (['xerces-c[icu]'], False),
    (['yasm'], False),

    (['dlib'], False),
]


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
