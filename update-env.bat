@echo off
set _ShowDebugMessages=%~1
if "%_ShowDebugMessages%" equ "" set _ShowDebugMessages=no

call :GetBatchFileDirectory _MyDir

call :SetOPT
if not defined OPT goto :EOF

set HOME=%USERPROFILE%\Home
set VCPKG_ROOT=%_MyDir%

for %%a in (
"%_MyDir%\installed\%Platform%-windows\share\clang"
"%_MyDir%\downloads\tools\7zip-18.1.0-windows\7-Zip.CommandLine.18.1.0\tools"
"%_MyDir%\downloads\tools\cmake-3.18.4-windows\cmake-3.18.4-win32-x86\bin"
"%_MyDir%\downloads\tools\gperf\bin"
"%_MyDir%\downloads\tools\jom\jom-1.1.3"
"%_MyDir%\downloads\tools\nasm\nasm-2.14.02"
"%_MyDir%\downloads\tools\ninja\1.10.1-windows"
"%_MyDir%\downloads\tools\nuget-5.5.1-windows"
"%_MyDir%\downloads\tools\perl\5.30.0.1\c\bin"
"%_MyDir%\downloads\tools\perl\5.30.0.1\c\i686-w64-mingw32\bin"
"%_MyDir%\downloads\tools\perl\5.30.0.1\site\bin"
"%_MyDir%\downloads\tools\perl\5.30.0.1\perl\bin"
"%_MyDir%\downloads\tools\powershell-core-7.0.3-windows"
"%_MyDir%\downloads\tools\python\python-3.8.3-%Platform%"
"%_MyDir%\downloads\tools\winflexbison\0a14154bff-a8cf65db07"
"%ProgramW6432%\Git\cmd"
"%SystemDrive%\Emacs\x86_64\bin"
"%SystemDrive%\Perl64\c\bin"
"%SystemDrive%\Perl64\perl\site\bin"
"%SystemDrive%\Perl64\perl\bin"
"%ProgramW6432%\LLVM\bin"
"%ProgramW6432%\LLVM\share\clang"
"%ProgramW6432%\nodejs"
"%ProgramW6432%\Python38"
"%ProgramW6432%\Perforce"
"%ProgramW6432%\TortoiseSVN\bin"
"%LOCALAPPDATA%\Pandoc"
"%ProgramW6432%\Pandoc"
"%ProgramFiles(x86)%\Poedit"
"%ProgramFiles(x86)%\Poedit\GettextTools\bin"
"%OPT%\Apache-Subversion-1.14.0\bin"
"%OPT%\bin\X64"
"%OPT%\bin\X86"
"%OPT%\ExamDiff"
"%OPT%\Scripts"
) do (
	call :AppendToPathIfExists "%%~a"
)

set HOME=%USERPROFILE%\Home
if exist "%_MyDir%\installed\%Platform%-windows\share\hunspell\dictionaries\." set DICPATH=%_MyDir%\installed\%Platform%-windows\share\hunspell\dictionaries

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
	SET _dir=%~dp0
	SET _dir=%_dir:~0,-1%
	if "%_dir%" EQU "" (
		set _dir=
		exit /b 1
	)
	set %1=%_dir%
	set _dir=
	exit /b 0
GOTO :EOF

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
