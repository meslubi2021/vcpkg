# improvement could be to use github vshwere to detect these paths
$installPath = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community"
$devShellPath = (Join-Path $installPath "Common7\Tools\Microsoft.VisualStudio.DevShell.dll")
powershell -noexit -command "Import-Module '$devShellPath'; Enter-VsDevShell -VsInstallPath '$installPath' -StartInPath '$pwd'"
