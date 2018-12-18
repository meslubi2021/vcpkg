$ErrorActionPreference = "Stop"

function Invoke-VcpkgBuild($pkg) {
	.\vcpkg.exe install $pkg`:x86-windows-mixed
	if ($LastExitCode -ne 0) { throw }
}

if (!(Test-Path vcpkg.exe)) { 
	scripts\bootstrap.ps1
	if ($LastExitCode -ne 0) { throw }
}

Invoke-VcpkgBuild "zlib"
Invoke-VcpkgBuild "sqlite3"
Invoke-VcpkgBuild "boost-system"
Invoke-VcpkgBuild "boost-atomic"
Invoke-VcpkgBuild "boost-chrono"
Invoke-VcpkgBuild "boost-regex"
Invoke-VcpkgBuild "boost-thread"
Invoke-VcpkgBuild "boost-filesystem"
Invoke-VcpkgBuild "boost-random"
Invoke-VcpkgBuild "boost-serialization"
Invoke-VcpkgBuild "boost-circular-buffer"
Invoke-VcpkgBuild "boost-asio"
Invoke-VcpkgBuild "fmt"
Invoke-VcpkgBuild "protobuf"
Invoke-VcpkgBuild "hiredis"
Invoke-VcpkgBuild "json-c"
Invoke-VcpkgBuild "libevent"
Invoke-VcpkgBuild "luajit"
Invoke-VcpkgBuild "lua-intf"
Invoke-VcpkgBuild "rapidxml"
Invoke-VcpkgBuild "pthread"
Invoke-VcpkgBuild "websocketpp"
Invoke-VcpkgBuild "curl"
Invoke-VcpkgBuild "libical"

# update the version anytime the installed package versions change
Write-Output 10 > installed/version.txt
