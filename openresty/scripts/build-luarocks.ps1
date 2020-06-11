$ErrorActionPreference = "Stop"

$Env:VCPKG_ROOT
$Env:MSVC_PACKAGE_ROOT

.\luarocks.bat install lua-cjson 2.1.0.6-1
.\luarocks.bat install lbase64 20120820-1
.\luarocks.bat install inspect 3.1.1-0
.\luarocks.bat install valua 0.3-1
.\luarocks.bat install router 2.1-0
.\luarocks.bat install lua-path 0.3.1-1
# moses must be pinned at 1.6.1-1, recent versions switch the order of arguments and completely break maxprofile
.\luarocks.bat install moses 1.6.1-1
.\luarocks.bat install uuid 0.2-1
.\luarocks.bat install lua-resty-http 0.15-0
.\luarocks.bat install luafilesystem 1.8.0-1
.\luarocks.bat install lsqlite3 0.9.5-1 "SQLITE_INCDIR=$Env:VCPKG_ROOT\include" "SQLITE_LIBDIR=$Env:VCPKG_ROOT\lib"
.\luarocks.bat install luasql-sqlite3 2.5.0-1 "SQLITE_INCDIR=$Env:VCPKG_ROOT\include" "SQLITE_LIBDIR=$Env:VCPKG_ROOT\lib"

.\luarocks.bat unpack luaossl 20190731-0
cd luaossl-20190731-0\luaossl-rel-20190731
cp "$Env:MSVC_PACKAGE_ROOT\patches\luaossl\*" .\
git init .
git apply --verbose 0001-fix-link-with-vcpkg-static-openssl.patch
..\..\.\luarocks.bat make "CRYPTO_DIR=$Env:VCPKG_ROOT" "OPENSSL_DIR=$Env:VCPKG_ROOT"
cd ..\..

.\luarocks.bat unpack phpass 1.0-1
cd phpass-1.0-1
cp "$Env:MSVC_PACKAGE_ROOT\patches\phpass\*" .\
git init .
git apply --verbose 0001-replace-luacrypto-with-luaossl.patch
cd lua-phpass
..\..\.\luarocks.bat make
cd ..\..

.\luarocks.bat unpack luajwt 1.3-4
cd luajwt-1.3-4
cp "$Env:MSVC_PACKAGE_ROOT\patches\luajwt\*" .\
git init .
git apply --verbose 0001-replace-luacrypto-with-luaossl.patch
cd luajwt
..\..\.\luarocks.bat make
cd ..\..
