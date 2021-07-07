#!/usr/bin/env python

import os
import subprocess

x64OnlyPackageList = [
  "chromium-base", "crashpad"
]

x86OnlyPackageList = [
]

packageList = [
  (['mpi'], False),
  (['boost-locale[icu]', 'boost-regex[icu]', 'boost[mpi]', 'flatbuffers', 'freeglut', 'fruit', 'gettext[core,tools]', 'glew', 'glog', 'glui', 'gtest', 'hunspell[core,tools]', 'icu', 'imgui-sfml', 'imgui[core,glfw-binding,glut-binding,sdl2-binding,win32-binding]', 'mpg123', 'mygui[core,opengl]', 'nana', 'nanogui', 'nuklear', 'poco[core,pdf,sqlite3]', 'protobuf[core,zlib]', 'qt[core,default-features]', 'sdl2', 'sdl2-gfx', 'sdl2-image', 'sdl2-image[core,libjpeg-turbo,libwebp,tiff]', 'sdl2-mixer[core,nativemidi,mpg123]', 'sdl2-net', 'sdl2-ttf', 'sdl2pp', 'sqlite-modern-cpp', 'sqlite3[core,json1,tool]', 'sqlitecpp[core,sqlite]', 'v8', 'yasm', 'yasm-tool'], False),

  (['7zip', 'abseil[core,cxx17]', 'aixlog', 'akali', 'angelscript[addons,core]', 'antlr4', 'approval-tests-cpp', 'apr[core,private-headers]', 'apr-util'], False),
  (['arabica', 'winsock2'], False),
  (['asmjit', 'atk', 'atkmm', 'dirent', 'gtk', 'gtkmm', 'scintilla'], False),
  (['audiofile', 'bdwgc', 'benchmark', 'berkeleydb', 'bigint', 'breakpad', 'bustache', 'capstone[core,x86]', 'cccapstone', 'catch2', 'chaiscript', 'chakracore', 'check', 'chmlib', 'cli', 'cli11', 'cmark', 'constexpr', 'constexpr-contracts', 'cpp-base64', 'cpp-httplib', 'cpp-peglib', 'cpprestsdk', 'cpptoml', 'cppunit', 'cppwinrt'] , False),
  (['cpu-features[core,tools]', 'cpuid', 'cpuinfo[core,tools]', 'crossguid', 'ctbignum', 'cute-headers', 'dbg-macro', 'dbghelp', 'detours'], False),
  (['crashpad'], False),
  (['d3dx12', 'directx-headers', 'directxsdk', 'directxtk12', 'dx', 'duilib'], False),
  (['discount', 'distorm', 'dlfcn-win32', 'duckx', 'duktape', 'eastl', 'easyhook', 'ecm'], False),
  (['exiv2[core,unicode]', 'fast-cpp-csv-parser', 'fast-float'], False),
  (['fltk', 'fmt', 'foonathan-memory[core,tool]', 'fplus', 'function2', 'gettimeofday'], False),
  (['inih', 'jansson', 'jbigkit', 'jemalloc', 'json-spirit', 'json11'] , False),
  (['libevent[core,thread]', 'libguarded', 'libsndfile', 'libui', 'libunibreak', 'libxml2', 'libxmlmm', 'libxslt', 'libyaml', 'licensepp'], False),
  (['llvm[core,clang,clang-tools-extra,default-options,default-targets,enable-ffi,enable-libxml2,lld,lldb,target-webassembly,tools,utils]'], False),
  (['lua[core,cpp,tools]', 'luabridge', 'luafilesystem', 'luajit'], False),
  (['magic-enum', 'mimalloc[core,secure]', 'mhook', 'minhook', 'mman', 'mp3lame', 'mpfr', 'ms-gsl', 'msinttypes', 'mstch', 'mujs'], False),
  (['nt-wrapper', 'numcpp', 'openal-soft', 'opencv4', 'openjpeg', 'p-ranav-csv2', 'pdcurses', 'phnt', 'platform-folders', 'portaudio', 'pprint', 'pthreads', 'pystring'], False),
  (['range-v3', 'rapidcsv', 'rapidjson', 'rapidxml', 'rmlui[core,freetype,lua]', 'ryml'], False),
  (['rttr', 'safeint', 'sfgui', 'strtk', 'simpleini', 'tbb', 'tgc', 'tgui[core,tool]', 'tidy-html5', 'tinyutf8', 'tinyxml', 'utf8h', 'utfcpp'], False),
  (['tcl', 'uriparser[core,tool]', 'xalan-c', 'wren', 'zstr', False),
  (['wil', 'wincrypt', 'winreg', 'wintoast', 'wtl'] , False),
  (['wxwidgets'], False),
  (['xerces-c[core,icu]', 'yaml-cpp'], False),
  (['nativefiledialog', 'quadtree', 'ragel', 'readline', 'refl-cpp', 'sciter', 'seal[core,zlib]', 'status-code', 'tinyfiledialogs', 'tinytoml', 'tomlplusplus', 'uchardet[core,tool]', 'uthenticode', 'wt[core,dbo,openssl,sqlite3]'], False),

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
  if (not common_member(x86OnlyPackageList, packages)):
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
