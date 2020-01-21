#!/usr/bin/env python

import os
import subprocess

packageList = [
    (['mpi', 'icu'], False),
    (['boost-locale[icu]', 'boost-regex[icu]', 'boost[mpi]'], True),

    (['angelscript', 'angelscript[addons]'], False),
    (['antlr4'], False),
    (['apr', 'apr-util'], False),
    (['bigint'], False),
    (['chaiscript'], False),
    (['chakracore'], False),
    (['cppunit'], False),
    (['dirent'], False),
    (['dlfcn-win32'], False),
    (['fltk'], False),
    (['fmt'], False),
    (['freeglut'], False),
    (['gettext'], False),
    (['gettimeofday'], False),
    (['atk', 'atkmm', 'gtk', 'gtkmm'], False),
    (['imgui', 'imgui[example]', 'imgui-sfml'], False),
    (['jbigkit'], False),
    (['libiconv'], False),
    (['libjpeg-turbo'], False),
    (['libsndfile'], False),
    (['libui'], False),
    (['lua', 'lua[cpp]', 'luabridge'], False),
    (['mhook'], False),
    (['minhook'], False),
    (['mman'], False),
    (['mp3lame'], False),
    (['ms-gsl'], False),
    (['nana'], False),
    (['nanogui'], False),
    (['nuklear'], False),
    (['openal-soft'], False),
    (['openjpeg'], False),
    (['pdcurses'], False),
    (['poco'], False),
    (['portaudio'], False),
    (['range-v3'], False),
    (['rapidxml'], False),
    (['sqlite3', 'sqlite3[tool]', 'sqlitecpp', 'sqlite-modern-cpp'], True),
    (['strtk'], False),
    (['tiff'], False),
    (['wtl'], False),
    (['wxwidgets'], False),
    (['xerces-c[icu]'], False),
    (['qt5'], False),
    (['sdl2', 'sdl2-net', 'sdl2-ttf', 'sdl2pp'], False),
    (['detours'], False),
    (['dlib'], False),
    (['glui'], False),
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
