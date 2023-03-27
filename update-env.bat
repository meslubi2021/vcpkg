@echo off
set _ShowDebugMessages=%~1
if "%_ShowDebugMessages%" equ "" set _ShowDebugMessages=no

set _IncludeMSYS64=%~2
if "%_IncludeMSYS64%" equ "" set _IncludeMSYS64=no


call :GetBatchFileDirectory _MyDir
call :SetOPT
if not defined OPT goto :EOF

set DOTNET_VERSION=7.0.202
set HOME=%USERPROFILE%\Home
set JDK_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.5.8-hotspot
set JDK_HOME_X64=C:\Program Files\Eclipse Adoptium\jdk-17.0.5.8-hotspot
set JDK_HOME_X86=C:\Program Files (x86)\Eclipse Adoptium\jdk-17.0.5.8-hotspot
set PANDOC_EXE=%LOCALAPPDATA%\Pandoc\pandoc.exe
set VCPKG_FEATURE_FLAGS=-binarycaching
set VCPKG_ROOT=%_MyDir%

if exist "%_MyDir%\installed\%Platform%-windows\share\hunspell\dictionaries\." set DICPATH=%_MyDir%\installed\%Platform%-windows\share\hunspell\dictionaries

for %%a in (
"%_MyDir%\installed\%Platform%-windows\share\clang"
"%_MyDir%\installed\%Platform%-windows\tools\gettext\bin"
"%_MyDir%\installed\%Platform%-windows\tools\icu\bin"
"%_MyDir%\installed\%Platform%-windows\tools\libiconv\bin"
"%_MyDir%\installed\%Platform%-windows\tools\Qt6\bin"
"%_MyDir%\installed\%Platform%-windows\tools\sassc\bin"
"%_MyDir%\installed\%Platform%-windows\tools\tcl\bin"
"%_MyDir%\downloads\tools\7z\Files\7-Zip"
"%_MyDir%\downloads\tools\cmake-3.25.0-windows\cmake-3.25.0-windows-i386\bin"
"%_MyDir%\downloads\tools\jom\jom-1.1.3"
"%_MyDir%\downloads\tools\nasm\nasm-2.15.05"
"%_MyDir%\downloads\tools\nasm\nasm-2.15.05\rdoff"
"%_MyDir%\downloads\tools\perl\5.32.1.1\c\bin"
"%_MyDir%\downloads\tools\perl\5.32.1.1\c\i686-w64-mingw32\bin"
"%_MyDir%\downloads\tools\perl\5.32.1.1\perl\site\bin"
"%_MyDir%\downloads\tools\perl\5.32.1.1\perl\bin"
"%_MyDir%\downloads\tools\python\python-3.10.7-%Platform%"
"%_MyDir%\downloads\tools\win_bison\2.5.25"
"%_MyDir%\downloads\tools\win_flex\2.5.25"
"%ProgramW6432%\Beyond Compare 4"
"%ProgramW6432%\Git\cmd"
"%SystemDrive%\Emacs\x86_64\bin"
"%SystemDrive%\Perl64\c\bin"
"%SystemDrive%\Perl64\perl\site\bin"
"%SystemDrive%\Perl64\perl\bin"
"%JDK_HOME%\bin"
"%JDK_HOME%\bin\server"
"%ProgramW6432%\dotnet"
"%ProgramW6432%\dotnet\sdk\%DOTNET_VERSION%"
"%USERPROFILE%\.dotnet\tools"
"%ProgramW6432%\LLVM\bin"
"%ProgramW6432%\LLVM\share\clang"
"%ProgramW6432%\nodejs"
"%ProgramW6432%\Perforce"
"%ProgramW6432%\PowerShell\7"
"%ProgramW6432%\Python310"
"%ProgramW6432%\TortoiseSVN\bin"
"%LOCALAPPDATA%\Pandoc"
"%ProgramFiles(x86)%\Poedit"
"%ProgramFiles(x86)%\Poedit\GettextTools\bin"
"%LOCALAPPDATA%\Programs\Microsoft VS Code"
"%OPT%\Apache-Subversion-1.14.2\bin"
"%OPT%\bin\X64"
"%OPT%\bin\X86"
"%OPT%\ExamDiff"
"%OPT%\Scripts"
) do (
  call :AppendToPathIfExists "%%~a"
)

call :AddMSYS64

goto :EOF

::
:: GetBatchFileDirectory
::
:: Gets the name of the directory in which the batch file is located.  The directory name will not
:: have a final trailing \ character.
::
:: The directory name is stored in the environment variable specified by the first parameter of the
:: function.
::
:GetBatchFileDirectory
  set _dir=%~dp0
  set _dir=%_dir:~0,-1%
  if "%_dir%" EQU "" (
    set _dir=
    exit /b 1
  )
  set %1=%_dir%
  set _dir=
  exit /b 0
goto :EOF

::
:: Searches for the OPT directory and sets the OPT environment variable to the
:: found directory.
::
:: The OPT directory will be in the root directory of the hard drive but it may
:: be installed on any hard drive.
::
:SetOPT
  if defined OPT exit /b 0
  for %%a in (c d e f g h i j k l m n o p q r s t u v w x y z) do (
    if exist "%%a:\opt\." (
      set OPT=%%a:\opt
      exit /b 0
    )
  )
  exit /b 1
goto :EOF

:AppendToPathIfExists
  if exist "%~1\." call :ShowDebugMessage "Adding '%~1' to the path."
  if not exist "%~1\." call :ShowDebugMessage "'%~1' does not exist."
  if exist "%~1\." set PATH=%PATH%;%~1
goto :EOF

:ShowDebugMessage
  if "%_ShowDebugMessages%" neq "yes" exit /b 1
  echo %~1
goto :EOF

:AddMSYS64
  if "%_IncludeMSYS64%" neq "yes" exit /b 1
  for %%a in (
  "%SystemDrive%\msys64\mingw64\local\bin"
  "%SystemDrive%\msys64\mingw64\opt\bin"
  "%SystemDrive%\msys64\mingw64\bin"
  "%SystemDrive%\msys64\usr\local\bin"
  "%SystemDrive%\msys64\usr\bin"
  ) do (
    call :AppendToPathIfExists "%%~a"
  )
goto :EOF
