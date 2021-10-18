$ErrorActionPreference = "Stop"

function Invoke-VcpkgBuild($pkg) {
	.\vcpkg.exe install $pkg`:x86-windows-mixed
	if ($LastExitCode -ne 0) { throw }
}

if (!(Test-Path vcpkg.exe)) { 
	scripts\bootstrap.ps1 -disableMetrics
	if ($LastExitCode -ne 0) { throw }
}

Invoke-VcpkgBuild "zlib"
Invoke-VcpkgBuild "sqlite3"
Invoke-VcpkgBuild "boost-circular-buffer"
Invoke-VcpkgBuild "boost-random"
Invoke-VcpkgBuild "boost-asio"
Invoke-VcpkgBuild "boost-geometry"
Invoke-VcpkgBuild "boost-qvm"
Invoke-VcpkgBuild "fmt"
Invoke-VcpkgBuild "json-c"
Invoke-VcpkgBuild "luajit"
Invoke-VcpkgBuild "lua-intf"
Invoke-VcpkgBuild "rapidxml"
Invoke-VcpkgBuild "libevent"
Invoke-VcpkgBuild "hiredis"
Invoke-VcpkgBuild "protobuf"
Invoke-VcpkgBuild "pthreads"
Invoke-VcpkgBuild "websocketpp"
Invoke-VcpkgBuild "curl"
Invoke-VcpkgBuild "gtest"

# export created libraries and set version
.\vcpkg.exe export --x-all-installed --raw
Move-Item -Path .\vcpkg-export-* -Destination .\vcpkg
Write-Output 12 > vcpkg\installed\version.txt
