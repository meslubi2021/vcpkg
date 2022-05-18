@echo off
set _ShowDebugMessages=%~1
if "%_ShowDebugMessages%" equ "" set _ShowDebugMessages=no

call :GetBatchFileDirectory _MyDir
call :SetOPT
if not defined OPT goto :EOF

set HOME=%USERPROFILE%\Home
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
"%_MyDir%\downloads\tools\cmake-3.22.2-windows\cmake-3.22.2-windows-i386\bin"
"%_MyDir%\downloads\tools\gn\qUkAhy9J0P7c5racy-9wB6AHNK_btS18im8S06_ehhwC"
"%_MyDir%\downloads\tools\gperf\bin"
"%_MyDir%\downloads\tools\jom\jom-1.1.3"
"%_MyDir%\downloads\tools\nasm\nasm-2.15.05"
"%_MyDir%\downloads\tools\nasm\nasm-2.15.05\rdoff"
"%_MyDir%\downloads\tools\perl\5.32.1.1\c\bin"
"%_MyDir%\downloads\tools\perl\5.32.1.1\c\i686-w64-mingw32\bin"
"%_MyDir%\downloads\tools\perl\5.32.1.1\perl\site\bin"
"%_MyDir%\downloads\tools\perl\5.32.1.1\perl\bin"
"%_MyDir%\downloads\tools\python\python-3.10.2-%Platform%"
"%_MyDir%\downloads\tools\win_bison\2.5.25"
"%ProgramW6432%\Beyond Compare 4"
"%ProgramW6432%\Git\cmd"
"%SystemDrive%\Emacs\x86_64\bin"
"%SystemDrive%\Perl64\c\bin"
"%SystemDrive%\Perl64\perl\site\bin"
"%SystemDrive%\Perl64\perl\bin"
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
"%OPT%\Apache-Subversion-1.14.0\bin"
"%OPT%\bin\X64"
"%OPT%\bin\X86"
"%OPT%\ExamDiff"
"%OPT%\Scripts"
) do (
  call :AppendToPathIfExists "%%~a"
)

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
