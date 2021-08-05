#!/usr/bin/env python

import os
import subprocess

packageList = [
    (['mpi'], False),
    (['boost-locale[icu]', 'boost-regex[icu]', 'boost[mpi]', 'icu', 'mpi', 'poco', 'poco[sqlite3]', 'sqlite3', 'sqlite3[tool]', 'sqlitecpp', 'sqlite-modern-cpp'], False),

    (['abseil', 'abseil[cxx17]', 'aixlog', 'akali', 'angelscript', 'angelscript[addons]', 'antlr4', 'apr', 'apr[private-headers]', 'apr-util'] , False),
    (['arabica'], False),
    (['asmjit'] , False),
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
