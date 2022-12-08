#!/usr/bin/env python

import os
import subprocess
import sys

x64OnlyPackageList = [
  "crashpad", 'eathread', 'folly[bzip2,zlib,zstd]', 'qt[default-features]', 'yasm-tool', 'yasm-tool-helper'
]

x86OnlyPackageList = [
]

packageList = [
  (['yasm-tool', 'yasm-tool-helper'], False),
  ([
    '3fd',
    '7zip',
    'abseil[core,cxx17]',
    'aixlog',
    'akali',
    'allegro5',
    'angelscript[addons,core]',
    'antlr4',
    'approval-tests-cpp',
    'apr-util[core,crypto]',
    'apr[core,private-headers]',
    'arabica',
    'asmjit',
    'atk',
    'atkmm',
    'atomic-queue',
    'audiofile',
    'b64',
    'bdwgc',
    'benchmark',
    'berkeleydb',
    'bigint',
    'blake3',
    'boost-asio[ssl]',
    'boost-locale[icu]',
    'boost-mpi[python3]',
    'boost-odeint[mpi]',
    'boost-regex[icu]',
    'boost[mpi]',
    'botan[core,zlib]',
    'breakpad',
    'buck-yeh-bux',
    'bullet3[core,multithreading]',
    'bustache',
    'bzip2[core,tool]',
    'capstone[core,x86]',
    'catch2',
    'cccapstone',
    'chaiscript',
    'chakracore',
    'check',
    'chipmunk',
    'chmlib',
    'cli',
    'cli11',
    'cmark[core,tools]',
    'color-console',
    'compoundfilereader',
    'constexpr-contracts',
    'constexpr',
    'coroutine',
    'cpp-base64',
    'cpp-httplib',
    'cpp-ipc',
    'cpp-peglib',
    'cpp-taskflow',
    'cpp-timsort',
    'cpprestsdk[default-features]',
    'cpptoml',
    'cppunit',
    'cppwinrt',
    'cppxaml',
    'cpu-features[core,tools]',
    'cpuid',
    'crashrpt',
    'crossguid',
    'ctbignum',
    'ctemplate',
    'cute-headers',
    'd3dx12',
    'dbg-macro',
    'dbghelp',
    'decimal-for-cpp',
    'detours',
    'directx-headers',
    'directxtk12',
    'dirent',
    'discount',
    'distorm',
    'dlfcn-win32',
    'duckx',
    'duilib',
    'duktape',
    'dx',
    'dxut[dxtk]',
    'eastl',
    'easyhook',
    'easyloggingpp',
    'ebml',
    'ecm',
    'eventpp',
    'exiv2[core,png,unicode]',
    'fakeit',
    'fast-cpp-csv-parser',
    'fast-float',
    'flash-runtime-extensions',
    'flat',
    'flatbuffers',
    'fltk',
    'fmt',
    'foonathan-memory[core,tool]',
    'fplus',
    'freeglut',
    'fruit',
    'ftxui',
    'function2',
    'gamedev-framework',
    'gettext[core,tools]',
    'gettimeofday',
    'glew',
    'glog',
    'glui',
    'gperf',
    'gppanel',
    'gtest',
    'gtk',
    'gtkmm',
    'guilite',
    'hash-library',
    'hunspell[core,tools]',
    'icu',
    'imgui-sfml',
    'imgui[core,allegro5-binding,glfw-binding,glut-binding,libigl-imgui,sdl2-binding,win32-binding]',
    'imguizmo',
    'implot',
    'inih',
    'jansson',
    'jbigkit',
    'jemalloc',
    'json-spirit',
    'json11',
    'json5-parser',
    'jsoncpp',
    'libcpplocate',
    'libevent[core,thread]',
    'libguarded',
    'libsndfile',
    'libui',
    'libunibreak',
    'libxml2[core,tools]',
    'libxmlmm',
    'libxslt[core,default-features]',
    'libyaml',
    'libzen',
    'licensepp',
    'llvm[core,clang,clang-tools-extra,default-options,default-targets,enable-ffi,enable-libxml2,lld,lldb,target-webassembly,tools,utils]',
    'lua[core,cpp,tools]',
    'luabridge',
    'luajit',
    'magic-enum',
    'mcpp',
    'mhook',
    'mimalloc[core,secure]',
    'minhook',
    'mman',
    'mp3lame',
    'mpfr',
    'mpg123',
    'mpi',
    'ms-gsl',
    'msinttypes',
    'mstch',
    'mujs',
    'mygui[core,opengl,tools]',
    'nana',
    'nanogui',
    'nativefiledialog',
    'nspr',
    'nt-wrapper',
    'nuklear[core,demo,example]',
    'numcpp',
    'openal-soft',
    'opencv4',
    'openjpeg',
    'p-ranav-csv2',
    'pdcurses',
    'phnt',
    'pkgconf',
    'platform-folders',
    'poco[core,pdf,sqlite3]',
    'portaudio',
    'pprint',
    'promise-cpp',
    'protobuf[core,zlib]',
    'proxy',
    'pthreads',
    'pystring',
    'quadtree',
    'ragel',
    'range-v3',
    'rapidcsv',
    'rapidjson',
    'rapidxml',
    'raylib[core,hidpi,use-audio]',
    'readline',
    'refl-cpp',
    'rmlui[core,freetype,lua]',
    'rttr',
    'ryml',
    'safeint',
    'scintilla',
    'sciter-js',
    'sdl2-gfx',
    'sdl2-image[core,libjpeg-turbo,libwebp,tiff]',
    'sdl2-mixer[core,nativemidi,mpg123]',
    'sdl2-net',
    'sdl2-ttf',
    'sdl2',
    'sdl2pp',
    'sfgui',
    'simpleini',
    'sqlite-modern-cpp',
    'sqlite3[core,json1,tool]',
    'sqlitecpp[core,sqlite]',
    'squirrel[interpreter]',
    'status-code',
    'strtk',
    'tbb',
    'tcl',
    'tgc',
    'tgui[core,sdl2,sfml,tool]',
    'threadpool',
    'tidy-html5',
    'tiny-aes-c',
    'tinydir',
    'tinyfiledialogs',
    'tinytoml',
    'tinyutf8',
    'tinyxml',
    'toml11',
    'tomlplusplus',
    'treehh',
    'tvision',
    'type-safe',
    'uberswitch',
    'uchardet[core,tool]',
    'uriparser[core,tool]',
    'utf8h',
    'utfcpp',
    'uthenticode',
    'wil',
    'wincrypt',
    'winlamb',
    'winreg',
    'winsock2',
    'wintoast',
    'wren',
    'wt[core,dbo,openssl,sqlite3]',
    'wtl',
    'wxcharts',
    'wxwidgets[core,example,sound,webview]',
    'xerces-c[core,icu]',
    'xqilla',
    'yaml-cpp',
    'yasm',
    'zstr'
  ], False),
  (['cpuinfo[core,tools]'], False),
  (['crashpad'], False),
  (['eathread'], False),
  (['folly[bzip2,zlib,zstd]'], False),
  (['qt[default-features]'], False),
  (['dlib'], False)
]

def GetScriptFile() -> str:
  """Obtains the full path and file name of the Python script."""
  if (hasattr(GetScriptFile, "file")):
    return GetScriptFile.file
  ret: str = ""
  try:
    # The easy way. Just use __file__.
    # Unfortunately, __file__ is not available when cx_freeze is used or in IDLE.
    ret = os.path.realpath(__file__)
  except NameError:
    # The hard way.
    if (len(sys.argv) > 0 and len(sys.argv[0]) > 0 and os.path.isabs(sys.argv[0])):
      ret = os.path.realpath(sys.argv[0])
    else:
      ret = os.path.realpath(inspect.getfile(GetScriptFile))
      if (not os.path.exists(ret)):
        # If cx_freeze is used the value of the ret variable at this point is in
        # the following format: {PathToExeFile}\{NameOfPythonSourceFile}. This
        # makes it necessary to strip off the file name to get the correct path.
        ret = os.path.dirname(ret)
  GetScriptFile.file: str = ret
  return GetScriptFile.file

def GetScriptDirectory() -> str:
  """Obtains the path to the directory containing the script."""
  if (hasattr(GetScriptDirectory, "dir")):
    return GetScriptDirectory.dir
  module_path: str = GetScriptFile()
  GetScriptDirectory.dir: str = os.path.dirname(module_path)
  return GetScriptDirectory.dir

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
  args.append("--x-buildtrees-root=%s/bt" % GetScriptDirectory())
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
