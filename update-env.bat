@echo off
set _ShowDebugMessages=%~1
if "%_ShowDebugMessages%" equ "" set _ShowDebugMessages=no

call :GetBatchFileDirectory _MyDir

call :SetOPT
if not defined OPT goto :EOF

for %%a in (
"%_MyDir%\downloads\tools\cmake-3.14.0-windows\cmake-3.14.0-win32-x86\bin"
"%_MyDir%\downloads\tools\perl\c\bin"
"%_MyDir%\downloads\tools\perl\site\bin"
"%_MyDir%\downloads\tools\perl\perl\bin"
"%_MyDir%\downloads\tools\powershell-core-6.2.1-windows"
"%_MyDir%\downloads\tools\python\python-3.7.3-x64"
"%ProgramFiles%\Git\cmd"
"%ProgramW6432%\Git\cmd"
"%LOCALAPPDATA%\Programs\PortableGit\cmd"
"%SystemDrive%\Perl64\c\bin"
"%SystemDrive%\Perl64\perl\site\bin"
"%SystemDrive%\Perl64\perl\bin"
"%ProgramFiles%\Python38"
"%ProgramW6432%\Python38"
"%ProgramFiles%\Perforce"
"%ProgramW6432%\Perforce"
"%ProgramFiles%\TortoiseSVN\bin"
"%ProgramW6432%\TortoiseSVN\bin"
"%OPT%\Apache-Subversion-1.12.2\bin"
"%LOCALAPPDATA%\Pandoc"
"%ProgramFiles%\Pandoc"
"%ProgramW6432%\Pandoc"
"%OPT%\bin\X64"
"%OPT%\bin\X86"
"%OPT%\ExamDiff"
"%OPT%\Scripts"
) do (
	call :AppendToPathIfExists "%%~a"
)

set HOME=%USERPROFILE%\Home

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
